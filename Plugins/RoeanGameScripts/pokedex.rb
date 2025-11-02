class Window_Pokedex
  alias __o__commands= commands=

  def commands=(value)
    @commands = value.reject do |cmd|
      species = cmd[:species]
      next true if species.nil?
      data = GameData::Species.get(species) rescue nil
      data && data.has_flag?("ExcludeFromDex")
    end
    refresh
  end
end
