# Module that can be included (mixin) to create and parse TSV data
module TsvBuddy
  # @data should be a data structure that stores information
  #  from TSV or Yaml files. For example, it could be an Array of Hashes.
  attr_accessor :data

  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    @data = []
    lines = tsv.split("\n")
    attribute_names = lines[0].split("\t")
    attribute_names.map!(&:chomp)
    # move all the lines below header line one line upper, we don't want the
    lines.shift
    lines.each do |line|
      hash_array = {}
      tokens = line.split("\t")
      tokens.map!(&:chomp)
      tokens.each_index { |index| hash_array[attribute_names[index]] = tokens[index] }
      @data.push(hash_array)
    end
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    # first we need to substract the headers, we will get it from the first hash
    first_element_keys = @data[0].keys
    header_line = ''
    first_element_keys.each { |token| header_line += token + "\t" }
    header_line.chomp!("\t")
    # turn each row into a row in tsv file
    tsv_string = ''
    # put column name on first line
    tsv_string << header_line << "\n"
    # turn each member of the yaml datas into a row in tsv file
    @data.each do |member|
      row_in_tsv_string = ''
      member.each_value { |value| row_in_tsv_string << value + "\t" }
      row_in_tsv_string.chomp!("\t")
      tsv_string << row_in_tsv_string << "\n"
    end
    tsv_string
  end
end
