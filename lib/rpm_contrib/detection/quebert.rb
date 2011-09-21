module NewRelic #:nodoc:
  # The class defined in the
  # newrelic_rpm[http://newrelic.github.com/rpm] which can be amended
  # to support new frameworks by defining modules in this namespace.
  class LocalEnvironment #:nodoc:
    module Quebert
      def discover_dispatcher
        super
        if defined?(::Quebert) && @dispatcher.nil?
          @dispatcher = 'quebert'
        end
      end
    end
  end
end

