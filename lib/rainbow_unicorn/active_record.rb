class RainbowUnicorn::ColorType < ActiveRecord::Type::Value
  def cast_value(value)
    case value
    when RainbowUnicorn::Color then value
    when String  then RainbowUnicorn::Color.from_hex(value)
    when Numeric then RainbowUnicorn::Color.from_i(value)
    else
      super
    end
  end

  def serialize(value)
    value.to_i
  end

  ActiveRecord::Type.register :rainbow_unicorn_color, self
end
