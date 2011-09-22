DependencyDetection.defer do
  depends_on do
    defined?(::Quebert::Job) && !NewRelic::Control.instance['disable_quebert']
  end

  executes do   
    ::Quebert::AsyncSender::ActiveRecord::RecordJob.class_eval do
      include NewRelic::Agent::Instrumentation::ControllerInstrumentation
      add_transaction_tracer :perform, :category => :task, :params => '{:record => args[0], :meth => args[1], :args => args.slice(2, args.length - 2)}'
    end

    ::Quebert::AsyncSender::Instance::InstanceJob.class_eval do
      include NewRelic::Agent::Instrumentation::ControllerInstrumentation
      add_transaction_tracer :perform, :category => :task, :params => '{:klass => args[0], :init_args => args[1], :meth => args[2], :args => args.slice(3, args.length - 3)}'
    end

    ::Quebert::AsyncSender::Object::ObjectJob.class_eval do
      include NewRelic::Agent::Instrumentation::ControllerInstrumentation
      add_transaction_tracer :perform, :category => :task, :params => '{:const => args[0], :meth => args[1], :args => args.slice(2, args.length - 2)}'
    end
  end
end