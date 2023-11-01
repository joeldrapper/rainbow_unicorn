
test "invalid rgb values" do
	expect { RainbowUnicorn::Color.new(256, 0, 0) }.to_raise(TypeError)
	expect { RainbowUnicorn::Color.new(0, 256, 0) }.to_raise(TypeError)
	expect { RainbowUnicorn::Color.new(0, 0, 256) }.to_raise(TypeError)

	expect { RainbowUnicorn::Color.new(-1, 0, 0) }.to_raise(TypeError)
	expect { RainbowUnicorn::Color.new(0, -1, 0) }.to_raise(TypeError)
	expect { RainbowUnicorn::Color.new(0, 0, -1) }.to_raise(TypeError)

	expect { RainbowUnicorn::Color.new(0.5, 0, 0) }.to_raise(TypeError)
	expect { RainbowUnicorn::Color.new(0, 0.5, 0) }.to_raise(TypeError)
	expect { RainbowUnicorn::Color.new(0, 0, 0.5) }.to_raise(TypeError)
end

test ".from_hsl" do
	expect(
		RainbowUnicorn::Color.from_hsl(0, 0, 0.39).rgb
	) == [99, 99, 99]
end

test ".from_hex" do
	expect(
		RainbowUnicorn::Color.from_hex("646464").rgb
	) == [100, 100, 100]
end

test "rgb" do
	expect(
		RainbowUnicorn::Color.new(100, 100, 100).rgb
	) == [100, 100, 100]
end

test "hex" do
	expect(
		RainbowUnicorn::Color.new(100, 100, 100).hex
	) == "#646464"
end

test "hsl" do
	expect(
		RainbowUnicorn::Color.new(100, 100, 100).hsl.map { _1.round(2) }
	) == [0, 0, 0.39]
end

test "red, green, blue" do
	color = RainbowUnicorn::Color.new(1, 2, 3)

	expect(color.red) == 1
	expect(color.r) == 1

	expect(color.green) == 2
	expect(color.g) == 2

	expect(color.blue) == 3
	expect(color.b) == 3
end

test "lighten" do
	expect(
		RainbowUnicorn::Color.new(100, 100, 100).lighten(0.1).rgb
	) == [126, 126, 126]
end

test "darken" do
	expect(
		RainbowUnicorn::Color.new(100, 100, 100).darken(0.1).rgb
	) == [74, 74, 74]
end

test "saturate" do
	expect(
		RainbowUnicorn::Color.new(100, 100, 100).saturate(0.1).rgb
	) == [110, 90, 90]
end

test "desaturate" do
	expect(
		RainbowUnicorn::Color.new(50, 60, 70).desaturate(0.1).rgb
	) == [56, 60, 64]
end

test "to_s" do
	expect(
		RainbowUnicorn::Color.new(100, 100, 100).to_s
	) == "rgb(100, 100, 100)"
end

test "to_h" do
	expect(
		RainbowUnicorn::Color.new(100, 100, 100).to_h
	) == { r: 100, g: 100, b: 100 }
end

test "deconstruct" do
	expect(
		RainbowUnicorn::Color.new(100, 100, 100).deconstruct
	) == [100, 100, 100]
end

test "deconstruct_keys" do
	expect(
		RainbowUnicorn::Color.new(100, 100, 100).deconstruct_keys([:r, :g, :b])
	) == { r: 100, g: 100, b: 100 }
end

test "inspect" do
	expect(
		RainbowUnicorn::Color.new(100, 100, 100).inspect
	) == "RainbowUnicorn::Color(100, 100, 100)"
end
