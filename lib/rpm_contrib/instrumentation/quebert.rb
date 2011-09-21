DependencyDetection.defer do
  depends_on do
    defined?(::Quebert::Job) && !NewRelic::Control.instance['disable_quebert']
  end

  executes do   
    ::Quebert::Job.subclasses.each do |klass|
      klass.constantize.class_eval do
        include NewRelic::Agent::Instrumentation::ControllerInstrumentation
        add_transaction_tracer :perform, :category => "Quebert/#{self.name.gsub(/^.*::/, '')}"
      end
    end 
  end
end