require 'active_support/concern'

module SearchAbility
  extend ActiveSupport::Concern

  included do
    PER_PAGE = 10
    
    attr_accessor :has_full_access
    attr_accessor :page

    def paginate
      if valid?
        _search.paginate(page: page,  :per_page => PER_PAGE)
      else
        self.class.none.paginate(page: page,  :per_page => PER_PAGE)
      end
    end

    private
    
    def _search
      if self.try(:approval_status).present? && approval_status == 'U'
        reln = self.class.unscoped.where("approval_status = ?", approval_status).order("#{self.class.table_name}.id desc")
      else
        reln = self.class.order("#{self.class.table_name}.id desc")
      end
      
      self.class.searchable_columns.each do |a|
        reln = reln.where("#{self.class.table_name}.#{a} = ?", self.try(a)) unless [nil, ''].include?(self.try(a))
      end

      self.class.between_attributes.each do |a|
        from_a = self.try("from_#{a}".to_sym)
        to_a = self.try("to_#{a}".to_sym)

        if self.class.columns_hash[a.to_s].type == :datetime
          from_a = Time.zone.parse(from_a) unless from_a.nil?
          to_a = Time.zone.parse(to_a) unless to_a.nil?
        end

        if ![nil, ''].include?(to_a) && ![nil, ''].include?(from_a)
          reln = reln.where("#{self.class.table_name}.#{a} between ? and ?", from_a, to_a)
        elsif ![nil, ''].include?(to_a)
          reln = reln.where("#{self.class.table_name}.#{a} < ?", to_a)
        elsif ![nil, ''].include?(from_a)
          reln = reln.where("#{self.class.table_name}.#{a} > ?", from_a)
        end
      end

      # call the find for custom finder code implemented in subclasses
      respond_to?(:find) ? reln.merge(find) : reln
      
    end
    

  end
  
  class_methods do
    def attr_searchable(*vars)
      @searchable_attributes ||= []
      @between_attributes ||= []
      @searchable_columns ||= []
      vars = vars.flat_map { |attr|
        if attr.is_a?(Hash) 
          @between_attributes << attr.key(:range)
          [:"from_#{attr.key(:range)}", :"to_#{attr.key(:range)}"]
        else
          attr
        end
      }
      vars |= [:page, :approval_status]
      @searchable_attributes.concat vars
      
      @searchable_attributes.each do |x|
        column_names.include?(x.to_s) ? @searchable_columns.append(x) : attr_accessor(x)
      end
    end
    
    def searchable_attributes
      @searchable_attributes
    end
    
    def between_attributes
      @between_attributes
    end

    def searchable_columns
      @searchable_columns
    end
  
  end
end