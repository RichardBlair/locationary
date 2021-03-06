require "./tests/test_helper"
require "./lib/locationary"
require "benchmark"
require "snappy"

class LocationaryPerformanceTests < MiniTest::Unit::TestCase
  def test_loading_data_speed

    raw = nil
    reading_speed = Benchmark.measure do
      raw = File.read("#{Dir.pwd}/db/geonames.bin")
    end
    puts "reading: #{reading_speed}"
    assert reading_speed.real < 0.1

    encoded = nil
    inflating_speed = Benchmark.measure do
      encoded = Snappy.inflate(raw)
    end
    puts "inflating speed: #{inflating_speed}"
    assert inflating_speed.real < 0.3

    data = nil
    unpacking_speed = Benchmark.measure do
      data = MessagePack.unpack(encoded)
    end
    puts "unpacking speed: #{unpacking_speed}"
    assert unpacking_speed.real < 1

  end
end