# frozen_string_literal: true

# Custom Error Class to don't mess up with the bot
module CustomExceptions
  DEV_MESSED_UP_MESSAGE = 'Something went **REALLY** wrong! Tell the dev he messed up with something'

  # Not able to Fetch API Data Error Class
  class CouldntRetrieveResource < StandardError
    def initialize(msg = "Couldn't get the resource", exception_type = 'wrong_parameter')
      @exception_type = exception_type
      super(msg)
    end
  end

  # The Data received is not correct
  class DataIsntInCorrectFormat < StandardError
    def initialize(msg = 'The data received is not correct', exception_type = 'wrong_data')
      @exception_type = exception_type
      super(msg)
    end
  end

  # The Data is too big to process
  class DataIsTooBigToProcess < StandardError
    def initialize(msg = 'The data received is too big to process', exception_type = 'data_too_big')
      @exception_type = exception_type
      super(msg)
    end
  end

  # The Data is too big to process
  class DataIsNotOnTheExpectedFormat < StandardError
    def initialize(msg = 'The data received is not in the expected format', exception_type = 'wrong_data_type', method: nil)
      @exception_type = exception_type
      @method_name = method unless method.nil?
      super(msg)
    end
  end
end
