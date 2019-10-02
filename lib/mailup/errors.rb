# frozen_string_literal: true

module MailUp
  class Error < StandardError
  end
  class BadRequest < Error
  end
  class ClientError < Error
  end
  class NotFound < Error
  end
  class ServerError < Error
  end
  class TooManyRequests < Error
  end
  class Unauthorized < Error
  end
  class Unavailable < Error
  end
end
