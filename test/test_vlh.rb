$LOAD_PATH.unshift(File.expand_path("lib"))
require 'digest/vlh'
require 'test/unit'

class VLHTest < Test::Unit::TestCase
  def test_instance_hexdigest
    length = 24
    vlh = Digest::VLH.new(length)
    vlh.update("Lorem ipsum dolor sit")
    digest = vlh.hexdigest

    assert_equal(length, digest.length)
    assert(/^[a-f0-9]+$/ =~ digest)
  end

  def test_class_method_hexdigest
    length = 24
    digest = Digest::VLH.hexdigest("Lorem ipsum dolor sit", length)

    assert_equal(length, digest.length)
    assert(/^[a-f0-9]+$/ =~ digest)
  end

  def test_instance_digest
    length = 24
    vlh = Digest::VLH.new(length)
    vlh.update("Lorem ipsum dolor sit")
    digest = vlh.digest

    assert_equal(length, digest.length)
    assert(/^[0-9^a-f]+$/ =~ digest)
  end

  def test_class_method_digest
    length = 24
    digest = Digest::VLH.digest("Lorem ipsum dolor sit", length)

    assert_equal(length, digest.length)
    assert(/^[0-9^a-f]+$/ =~ digest)
  end

  def test_reset
    vlh = Digest::VLH.new(12)
    vlh << "Lorem ipsum dolor sit"
    d1 = vlh.hexdigest
    vlh.reset
    d2 = vlh.hexdigest
    assert_not_equal(d1, d2)
  end

  def test_left_pad
    digest = Digest::VLH.hexdigest("1", 16)

    assert_equal("029b8a3b0e189ad1", digest)
  end

  def test_zero_length_hexdigest
    digest = Digest::VLH.hexdigest("Lorem ipsum", 0)

    assert_equal(0, digest.length)
  end

  def test_zero_length_digest
    digest = Digest::VLH.digest("Lorem ipsum", 0)

    assert_equal(0, digest.length)
  end
end
