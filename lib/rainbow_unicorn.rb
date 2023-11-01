# frozen_string_literal: true

require "zeitwerk"

module RainbowUnicorn
	Loader = Zeitwerk::Loader.for_gem.tap do |loader|
		loader.ignore("#{__dir__}/**/*.test.rb")
		loader.setup
	end
end
