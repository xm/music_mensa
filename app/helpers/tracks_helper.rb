module TracksHelper
  def ugly_lyrics(lyrics)
    return "no lyrics to display" if lyrics.nil?

    lyrics.split("\r\n").map do |l| 
      l.length > 0 ? "♫ ".concat(l) : ""
    end.join("\r\n")
  end
end
