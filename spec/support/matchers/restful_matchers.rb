module Restful
  module Matchers
    class HaveUpdatedResource
      def initialize(resource, location)
        @resource = resource
        @location = location
      end

      def matches?(target)
        @response = target
        failed = false
        @message = "expected the updated resource to be non nil but was nil" and failed = true unless failed || !@resource.nil?
        @message = "expected the response code to be found(302) but was #{@response.code}" and failed = true unless failed || @response.code == "302"
        @message = "expected the response location to be #{@location} but was #{@response.location}" and failed = true unless failed || @response.location == @location
        !failed
      end

      def failure_message_for_should
        @message
      end

      def failure_message_for_should_not
        <<MESSAGE
expected the resource to be nil and was #{@resource.inspect},
response code not to be 201 and was #{@response.code},
response location not to be #{@location} and was #{@response.location}
MESSAGE
      end
    end

    def have_updated_resource(resource, location)
      HaveUpdatedResource.new(resource, location)
    end

    class BeUnauthorized
      def matches?(target)
        @response = target
        failed = false
        @message = "expected the response code to be unauthorized(401) but was #{@response.code}" and failed = true unless failed || @response.code == "401"
        !failed
      end

      def failure_message_for_should
        @message
      end

      def failure_message_for_should_not
        "expected the response code not to be unauthorized(401) but was #{@response.code}"
      end
    end

    def be_unauthorized
      BeUnauthorized.new
    end

    class BeRedirectTo
      def initialize(location)
        @location = location
      end

      def matches?(target)
        @response = target
        @message = "expected the response code to be redirect(302) but was #{@response.code}" and return false unless @response.code == "302"
        @message = "expected the response redirect location to be #{@location} but was #{@response.location}" and return false unless @response.location == @location
        return true
      end

      def failure_message_for_should
        @message
      end

      def failure_message_for_should_not
        <<MESSAGE
        expected the response code not to be redirect(401) but was #{@response.code}
and redirect location not to be #{@location} but was #{@response.location}"
MESSAGE
      end
    end

    def be_redirect_to(location)
      BeRedirectTo.new(location)
    end

    class HaveCreatedResource
      def initialize(resource, location)
        @resource = resource
        @location = location
      end

      def matches?(target)
        @response = target
        failed = false
        @message = "expected the created resource to be non nil but was nil" and failed = true unless failed || !@resource.nil?
        @message = "expected the response code to be created(201) but was #{@response.code}" and failed = true unless failed || @response.code == "201"
        !failed
      end

      def failure_message_for_should
        @message
      end

      def failure_message_for_should_not
        <<MESSAGE
expected the created resource to be non nil and was #{@resource.inspect},
expected the response code not to be created(201) and was #{response.code}
MESSAGE
      end
    end

    def have_created_resource(resource, location)
      HaveCreatedResource.new(resource, location)
    end

    class BeRestful
      def matches?(target)
        @resource = target.to_s
        resources = @resource.pluralize
        failed = false
        @message = "expected index path for resources to be /#{resources} but was #{generated_path}" and failed = true unless failed || (generated_path = send(:"#{resources}_path")) == "/#{resources}"
        @message = "" and failed = true unless failed || send(:"new_#{@resource}_path") == "/#{resources}/new"
        @message = "" and failed = true unless failed || send(:"edit_#{@resource}_path", 1) == "/#{resources}/1/edit"
        @message = "" and failed = true unless failed || send(:"#{@resource}_path", 1) == "/#{resources}/1"
        !failed
      end
    end
  end
end