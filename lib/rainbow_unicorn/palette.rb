module RainbowUnicorn
	class Palette
		def self.define(**colors)
		  new(
				colors.transform_values { |rgb| RainbowUnicorn::Color.new(*rgb) }
			)
		end

		def initialize(colors)
			@colors = colors.freeze
			freeze
		end

		def each(&)
			@colors.each(&)
		end

		def names
			@colors.keys
		end

		def each_name(&)
			@colors.keys.each(&)
		end

		def colors
			@colors.values
		end

		alias_method :to_a, :colors
		alias_method :to_ary, :colors

		def each_color(&)
			@colors.values.each(&)
		end

		def rgb_colors
			@colors.values.map(&:rgb)
		end

		def to_h
			@colors
		end

		def [](code)
			@colors[code]
		end
	end
end
