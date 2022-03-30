# frozen_string_literal: true

module Request
  def http_namespace(action)
    # Based on our request method we can add more actions
    case action
    when :create then Net::HTTP::Post
    end
  end
end
