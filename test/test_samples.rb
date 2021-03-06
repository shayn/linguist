require 'linguist/samples'

require 'test/unit'

class TestSamples < Test::Unit::TestCase
  include Linguist

  def test_up_to_date
    assert serialized = Samples::DATA
    assert latest = Samples.data

    # Just warn, it shouldn't scare people off by breaking the build.
    if serialized['md5'] != latest['md5']
      warn "Samples database is out of date. Run `bundle exec rake samples`."
    end
  end

  def test_verify
    assert data = Samples::DATA

    assert_equal data['languages_total'], data['languages'].inject(0) { |n, (_, c)| n += c }
    assert_equal data['tokens_total'], data['language_tokens'].inject(0) { |n, (_, c)| n += c }
    assert_equal data['tokens_total'], data['tokens'].inject(0) { |n, (_, ts)| n += ts.inject(0) { |m, (_, c)| m += c } }
  end
end
