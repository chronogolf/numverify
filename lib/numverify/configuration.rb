# frozen_string_literal: true

module NumverifyClient
  class Configuration
    attr_accessor :access_key, :https

    def initialize
      @access_key = nil
      @https = false
    end
  end
end
