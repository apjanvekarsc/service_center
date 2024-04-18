module ActionDispatch::Routing
  class Mapper
    def operation_routes_for(op_name, controller = "operations")
    
      get op_name => "#{controller}#index"
      put op_name => "#{controller}#index"
      get "#{op_name}/:id/steps" => "#{controller}#steps", as: "steps_#{op_name.singularize}"
      get "#{op_name}/:id" => "#{controller}#show", as: op_name.singularize
    
    end
  end
end
