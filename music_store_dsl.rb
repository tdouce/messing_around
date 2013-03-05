# Ruby 1.9.3. Learning DSLs. My first one

class Album
  attr_writer :record_label, :name, :year
  attr_reader :tracks, :artist

  def initialize(artist, &block)
    @artist = artist
    @tracks = []
    instance_eval(&block) if block_given?
  end

  def track(name, &block)
    if (track = Track.new(name)) && block_given?
      track.instance_eval(&block)
    end
    @tracks << track 
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

class Track 
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
    output << "Tracks: #{@album.tracks.length} \n"
    
    @album.tracks.each_with_index do |track,i|
      output << " #{i + 1}. #{ track.name }"
      output << " (#{ track.duration })" unless track.duration.nil?
      output << "\n     featuring: #{ track.featuring }" unless track.featuring.nil? 
      output << "\n     * explicit lyrics" if track.explicit_lyrics == true
      if !track.instruments.empty?
        output << "\n"
        output << "     instruments: " << track.instruments.join(", ")
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

  track "Horn Intro" do	
    duration "0:11"
    featuring "Travis Douce"
    instrument "guitar"
    instrument "drums"
    instrument "trumpet"
  end

  track "The World At Large" do	 
    duration "4:32"
    featuring "Dr. Dre"
    instrument "guitar"
    instrument "drums"
  end

  track "Float On" do	 
    duration "3:28"
  end

  track "Ocean Breathes Salty" do
    duration "3:44"
    instrument "guitar"
    instrument "drums"
    instrument "banjo"
  end

  track "Dig Your Grave" do	
    duration "0:17"
    instrument "tuba"
  end

  track "Bury Me With It" do	 
    duration "3:49"
  end

  track "Dance Hall" do 
    explicit_lyrics true
    duration "2:57"
  end

  track "Bukowski" do
    explicit_lyrics true 
    duration "4:14"
  end

  track "This Devil's Workday" do
    duration "2:19"
  end

  track "The View" do 
    explicit_lyrics true 
    duration "4:10"
  end

  track "Satin In A Coffin" do	 
    duration "2:38"
  end

  track "Interlude (Milo)" do
    duration "0:58"
  end

  track "Blame It On The Tetons" do
    duration "5:25"
  end 

  track "Black Cadillacs" do 
    explicit_lyrics true
    duration "2:43"
  end

  track "One Chance" do	 
    duration "3:01"
  end

  track "The Good Times Are Killing Me" do
    explicit_lyrics true
    duration "4:19"
  end
end

bob_dylan = Album.new("Bob Dylan") do 
  name "Desire"
  record_label "Universal Music Group"
  year 1975 

  track "Hurricane" do 
    duration '11:32'
    instrument "guitar"
    instrument "tambourine"
  end

  track "Isis" do  
    duration "6:58"
  end

  track "Mozambique" do 
    duration "3:00"
    instrument "guitar"
    instrument "fiddle"
    instrument "harmonica"
  end

  track "One More Cup Of Coffee"
  track "Oh, Sister"
  track "Joey" 
  track "Romance In Durango"
  track "Black Diamond Bay" 

  track "Sara" do 
    duration "5:31"
    instrument "banjo"
  end
end


bob_dylan.to_s
modest_mouse.to_s





