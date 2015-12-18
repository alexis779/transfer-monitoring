require 'test_helper'

class PingsControllerTest < ActionController::TestCase
  def one
    @one ||= parse_json(open("test/fixtures/ping.json").read)
  end

  def parse_json(body)
    JSON.parse(body, symbolize_names: true)
  end

  test "should add a new ping " do
    assert_equal(one[:origin], "sdn-probe-moscow")

    assert_equal 0, Ping.count
    assert_equal 0, PingAggregate.count
    post :create, one
    assert_equal 1, Ping.count
    assert_equal 1, PingAggregate.count

    result = parse_json(response.body)
    assert_equal result[:id], Ping.first.id
  end

  test "should get average transfer time hourly by origin" do
    post :create, one

    get :hours, origin: one[:origin]
    result = parse_json(response.body)
    assert_equal result, [ [ 1439240400000, 135 ] ]
  end

  test "should list the origins" do
    post :create, one

    get :origins
    result = parse_json(response.body)
    assert_equal result, [ one[:origin] ]
  end
end
