# frozen_string_literal: true

module RainbowUnicorn
	class Color
		def initialize(r, g, b)
			unless Integer === r && Integer === g && Integer === b
				raise TypeError, "rgb values must be integers"
			end

			unless (0..255) === r && (0..255) === g && (0..255) === b
				raise TypeError, "rgb values must be between 0 and 255"
			end

			@rgb = [r, g, b].freeze
			freeze
		end

		def self.from_hsl(h, s, l)
			unless (0..360) === h && (0..1) === s && (0..1) === l
				raise TypeError, "hsl values must be between 0 and 360 for h and 0 and 1 for s and l"
			end

			c = (1 - ((2 * l) - 1).abs) * s
			x = c * (1 - (((h / 60.0) % 2) - 1).abs)
			m = l - (c / 2.0)

			r1, g1, b1 = if h < 60
				[c, x, 0]
			elsif h < 120
				[x, c, 0]
			elsif h < 180
				[0, c, x]
			elsif h < 240
				[0, x, c]
			elsif h < 300
				[x, 0, c]
			else
				[c, 0, x]
			end

			r = ((r1 + m) * 255).round
			g = ((g1 + m) * 255).round
			b = ((b1 + m) * 255).round

			new(r, g, b)
		end

		def self.from_hex(hex)
			unless String === hex && hex.length == 6
				raise ArgumentError, "Invalid hex color"
			end

			r, g, b = hex.scan(/../).map { |color| color.to_i(16) }
			new(r, g, b)
		end

		def hsl
			rgb = @rgb.map { |c| c / 255.0 }
			max, min = rgb.max, rgb.min

			r, g, b = rgb
			h, s, l = 0, 0, (max + min) / 2.0

			if max != min
				d = max - min
				s = l > 0.5 ? d / (2.0 - max - min) : d / (max + min)
				case max
				when r
					h = ((g - b) / d) + (g < b ? 6.0 : 0)
				when g
					h = ((b - r) / d) + 2.0
				when b
					h = ((r - g) / d) + 4.0
				end
				h /= 6.0
			end

			[h * 360, s, l]
		end

		attr_reader :rgb
		alias_method :to_a, :rgb
		alias_method :deconstruct, :rgb

		def to_h
			{ r: @rgb[0], g: @rgb[1], b: @rgb[2] }
		end

		def deconstruct_keys(keys)
			{ r: @rgb[0], g: @rgb[1], b: @rgb[2] }
		end

		def inspect
			"#{self.class.name}(#{@rgb.join(', ')})"
		end

		def hex
			"##{rgb.map { |c| c.to_s(16).rjust(2, '0') }.join}"
		end

		def relative_luminance
			# Convert 8-bit RGB to the range 0-1
			rsrgb = r / 255.0
			gsrgb = g / 255.0
			bsrgb = b / 255.0

			# Apply the piecewise linear transformation
			r = rsrgb <= 0.04045 ? rsrgb / 12.92 : ((rsrgb + 0.055) / 1.055)**2.4
			g = gsrgb <= 0.04045 ? gsrgb / 12.92 : ((gsrgb + 0.055) / 1.055)**2.4
			b = bsrgb <= 0.04045 ? bsrgb / 12.92 : ((bsrgb + 0.055) / 1.055)**2.4

			# Calculate relative luminance
			(0.2126 * r) + (0.7152 * g) + (0.0722 * b)
		end

		def contrast_ratio(other)
			a = relative_luminance
			b = other.relative_luminance

			a > b ? (a + 0.05) / (b + 0.05) : (b + 0.05) / (a + 0.05)
		end

		def to_s
			"rgb(#{rgb.join(', ')})"
		end

		def red
			@rgb[0]
		end

		alias_method :r, :red

		def green
			@rgb[1]
		end

		alias_method :g, :green

		def blue
			@rgb[2]
		end

		alias_method :b, :blue

		def lighten(amount)
			h, s, l = hsl
			self.class.from_hsl(h, s, [(l + amount), 1].min)
		end

		def darken(amount)
			h, s, l = hsl
			self.class.from_hsl(h, s, [(l - amount), 0].max)
		end

		def saturate(amount)
			h, s, l = hsl
			self.class.from_hsl(h, [(s + amount), 1].min, l)
		end

		def desaturate(amount)
			h, s, l = hsl
			self.class.from_hsl(h, [(s - amount), 0].max, l)
		end
	end
end
