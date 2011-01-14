class PdfProcessor

  def initialize(input)
    @input_file = input
    @filename = input_file.split('.')[0]
  end

  public:

    def process(output)

      path = File.join(output, @filename)

      # Convert the PDF to a swf file
      puts `pdf2swf #{@input_file} -o #{path}.swf -T 9 -f`

      # Sanitize the PDF
      puts `gs -o #{@filename}-sanitized -sDEVICE=pdfwrite -f #{@input_file}`

      # Output a full, plain text version of the PDF (if possible)
      puts `pdftotext -layout -enc Latin1 -nopgbrk #{@input_file} #{@filename}.txt`

      # If the textfile is empty, then run the OCR routine
      content = File.open(@filename + ".txt") { |f| f.read }
      if content.length == 0
        ocr @input_file, @filename
      end

      # Delete the original pdf, and the sanitised pdf
      File.delete(@input_file)
      File.delete(@filename + "-sanitized")

    end

  private:

    def ocr(p_input_file, p_filename)

      dirname = p_filename + "_images"

      # Step 1: Extract images from file
      Dir.mkdir dirname
      `pdfimages -j #{p_input_file} #{dirname}/#{p_filename}`

      # Step 2: Run OCR on each file in the images dir
      output = ""
      Dir.foreach(dirname) do |file|
        if file != '.' and file != '..'
          path = File.join(dirname, file) 
          `gocr -i #{path} -o #{path}.txt -f ASCII`
          output = output << File.open(path + ".txt", "r") { |f| f.read }
        end
      end

      # Step 3: Write out OCR'd text
      puts "Writing " << p_filename + ".txt"
      File.open(p_filename + ".txt", "w") { |file| file.puts output }
  
      # Step 4: Delete the directory
      puts "Deleting " + dirname
      Dir.foreach(dirname) do |file|
        if file != '.' and file != '..'
          File.delete File.join(dirname, file)
        end
      end
      Dir.rmdir dirname

    end

end
