require File.dirname(__FILE__) + "/../../test_helper"

module DeepTest
  module Distributed
    unit_tests do
      test "push_code is invoked on all servers" do
        server_1, server_2 = mock, mock
        options = Options.new({:ui => "UI::Null"})

        fleet = LandingFleet.new(options, [server_1, server_2])

        server_1.expects(:push_code).with(options)
        server_2.expects(:push_code).with(options)

        fleet.push_code(options)
      end

      test "establish_beachhead is invoked on all server" do
        server_1, server_2 = mock, mock
        options = Options.new({:ui => "UI::Null"})

        fleet = LandingFleet.new(options, [server_1, server_2])

        server_1.expects(:establish_beachhead).with(options)
        server_2.expects(:establish_beachhead).with(options)

        fleet.establish_beachhead(options)
      end

      test "establish_beachhead returns Beachheads with each agent" do
        server_1 = mock(:establish_beachhead => :beachhead_1)
        server_2 = mock(:establish_beachhead => :beachhead_2)
        options = Options.new({:ui => "UI::Null"})

        fleet = LandingFleet.new(options, [server_1, server_2])

        LandingFleet::Beachheads.
          expects(:new).with(options, [:beachhead_1, :beachhead_2])

        fleet.establish_beachhead(options)
      end

      test "Beachheads dispatches deploy_agents" do
        server_1, server_2 = mock, mock

        beachheads = LandingFleet::Beachheads.new(
          Options.new({:ui => "UI::Null"}),
          [server_1, server_2]
        )

        server_1.expects(:deploy_agents)
        server_2.expects(:deploy_agents)

        beachheads.deploy_agents
      end

      test "Beachheads dispatches load_files" do
        server_1, server_2 = mock, mock

        beachheads = LandingFleet::Beachheads.new(
          Options.new({:ui => "UI::Null"}),
          [server_1, server_2]
        )

        server_1.expects(:load_files).with(:filelist)
        server_2.expects(:load_files).with(:filelist)

        beachheads.load_files :filelist
      end
    end
  end
end
