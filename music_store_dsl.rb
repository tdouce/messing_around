# Ruby 1.9.3. Learning DSLs. My first one

class Album
  attr_writer :record_label, :name, :year
  attr_reader :songs, :artist

  def initialize(artist, &block)
    @artist = artist
    @songs = []
    instance_eval(&block) if block_given?
  end

  def song(name, &block)
    if (song = Song.new(name)) && block_given?
      song.instance_eval(&block)
    end
    @songs << song 
  end

  def record_label(record_label_name = nil)
    return @record_label if record_label_name.nil?
    self.record_label = record_label_name
  end

  def name(name = nil)
    return @name if name.nil?
    self.name = name
  end

  def year(year = nil)
    return @year if year.nil?
    self.year = year
  end

  def to_s
    ap = AlbumPrinter.new(self)
    ap.to_s
  end
end

class Song
  attr_accessor :name, :instruments
  attr_writer :featuring, :explicit_lyrics, :duration

  def initialize(name)
    @name = name
    @instruments = []
  end

  def instrument(name)
    @instruments << name
  end

  def featuring(artist = nil)
    return @featuring if artist.nil?
    self.featuring = artist 
  end

  def explicit_lyrics(explicit = nil)
    return @explicit_lyrics if explicit.nil?
    self.explicit_lyrics = explicit
  end

  def duration(duration = nil)
    return @duration if duration.nil?
    self.duration = duration
  end
end

class AlbumPrinter
  def initialize(album)
    @album = album
  end

  def to_s
    output = ""
    output << "*"*10 << "\n"
    output << "Artist: #{@album.artist} \n"
    output << "Record Label: #{@album.record_label} \n"
    output << "Album: #{@album.name} \n"
    output << "Year: #{@album.year} \n"
    output << "Tracks: #{@album.songs.length} \n"
    
    @album.songs.each_with_index do |song,i|
      output << " #{i + 1}. #{ song.name }"
      output << " (#{ song.duration })" unless song.duration.nil?
      output << "\n     featuring: #{ song.featuring }" unless song.featuring.nil? 
      output << "\n     * explicit lyrics" if song.explicit_lyrics == true
      if !song.instruments.empty?
        output << "\n"
        output << "     instruments: " << song.instruments.join(", ")
      end
      output << "\n"
    end
    puts output
  end
end

modest_mouse = Album.new("Modest Mouse") do 
  name "Good News for People Who Love Bad News"
  year "2004"
  record_label "SONY Music Entertainment Downloads LLC."

  song "Horn Intro" do	
    duration "0:11"
    featuring "Travis Douce"
    instrument "guitar"
    instrument "drums"
    instrument "trumpet"
  end

  song "The World At Large" do	 
    duration "4:32"
    featuring "Dr. Dre"
    instrument "guitar"
    instrument "drums"
  end

  song "Float On" do	 
    duration "3:28"
  end

  song "Ocean Breathes Salty" do
    duration "3:44"
    instrument "guitar"
    instrument "drums"
    instrument "banjo"
  end

  song "Dig Your Grave" do	
    duration "0:17"
    instrument "tuba"
  end

  song "Bury Me With It" do	 
    duration "3:49"
  end

  song "Dance Hall" do 
    explicit_lyrics true
    duration "2:57"
  end

  song "Bukowski" do
    explicit_lyrics true 
    duration "4:14"
  end

  song "This Devil's Workday"	do
    duration "2:19"
  end

  song "The View" do 
    explicit_lyrics true 
    duration "4:10"
  end

  song "Satin In A Coffin" do	 
    duration "2:38"
  end

  song "Interlude (Milo)" do
    duration "0:58"
  end

  song "Blame It On The Tetons" do
    duration "5:25"
  end 

  song "Black Cadillacs" do 
    explicit_lyrics true
    duration "2:43"
  end

  song "One Chance" do	 
    duration "3:01"
  end

  song "The Good Times Are Killing Me" do
    explicit_lyrics true
    duration "4:19"
  end
end

modest_mouse.to_s



bob_dylan = Album.new("Bob Dylan") do 
  name "Desire"
  record_label "Universal Music Group"
  year 1975 

  song "Hurricane" do 
    duration '11:32'
    instrument "guitar"
    instrument "tambourine"
  end

  song "Isis" do  
    duration "6:58"
  end

  song "Mozambique" do 
    duration "3:00"
    instrument "guitar"
    instrument "fiddle"
    instrument "harmonica"
  end

  song "One More Cup Of Coffee"
  song "Oh, Sister"
  song "Joey" 
  song "Romance In Durango"
  song "Black Diamond Bay" 

  song "Sara" do 
    duration "5:31"
    instrument "banjo"
  end
end

bob_dylan.to_s






