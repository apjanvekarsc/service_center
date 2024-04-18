class Searcher
  include ActiveModel::Model
  include ActiveModel::Validations
  extend SimpleEnum::Attribute

  attr_accessor :has_full_access
  
  
  def self.attr_searchable(*vars)
    @attributes ||= []
    @between_attributes ||= []    
    vars = vars.flat_map { |attr|
      if attr.is_a?(Hash) 
        @between_attributes << attr.key(:range)
        [:"from_#{attr.key(:range)}", :"to_#{attr.key(:range)}"]
      else
        attr
      end
    }
    vars |= [:page, :approval_status]
    @attributes.concat vars
    attr_accessor(*vars)
  end

  PER_PAGE = 10

  def initialize(attributes = {})
    (attributes.to_h).each do |name, value|
      send("#{name}=", value)
    end
  end

  def export
    find
  end

  def persisted?
    false
  end      

  def klass
    self.class.klass
  end
  
  # the policy class is the same as that of the model
   def self.policy_class
     "#{name.chomp('Searcher')}Policy".constantize
   end
  
  def paginate
    if valid?
      _find.paginate(page: page,  :per_page => PER_PAGE)
    else
      klass.none.paginate(page: page,  :per_page => PER_PAGE)
    end
  end

  def _find
    if self.try(:approval_status).present? && approval_status == 'U'
      reln = klass.unscoped.where("#{klass.table_name}.approval_status = ?", approval_status).order("#{klass.table_name}.id desc")
    else
      reln = klass.order("#{klass.table_name}.id desc")
    end
    attrs.each do |a|
      if klass.table_name == "nach_members" || klass.table_name == "ft_invoice_details" || klass.table_name == "funds_transfers" || klass.table_name == "imt_customers" || klass.table_name == "imt_partners" || klass.table_name == "imt_withdrawals" || klass.table_name == "imt_add_beneficiaries" || klass.table_name == "imt_del_beneficiaries" || klass.table_name == "imt_initiate_transfers" || klass.table_name == "imt_cancel_transfers" || klass.table_name == "imt_resend_otp" || klass.table_name == "imt_withdraw_reversals" || klass.table_name == "imt_initiate_withdrawals" || klass.table_name == "rx_apps" || klass.table_name == "rx_services" || klass.table_name == "rx_consumers" || klass.table_name == "rx_access_logs" || klass.table_name == "sc_services" || klass.table_name == "rpl_fault_codes" || klass.table_name == "remit_ledger_credits" || klass.table_name == "rpl_ledger_credits" || klass.table_name == "icol_customers" || klass.table_name == "icol_validate_steps" || klass.table_name == "icol_notifications" || klass.table_name == "partners" || klass.table_name == "purpose_codes" || klass.table_name == "whitelisted_identities" || klass.table_name == "partner_lcy_rates" || klass.table_name == "gem_buyers" || klass.table_name == "gem_ddos" || klass.table_name == "gem_bgs" || klass.table_name == "cc_customers" || klass.table_name == "cc_cust_cards" || klass.table_name == "cc_fee_rules" || klass.table_name == "cc_transfers" || klass.table_name == "ecol_apps" || klass.table_name == "fp_operations" || klass.table_name == "fp_services"
        reln = reln.where("#{klass.table_name}.#{a} IN (?)", self.try(a).split(",").collect(&:strip)) unless [nil, ''].include?(self.try(a))
      else
        reln = reln.where("#{klass.table_name}.#{a} = ?", self.try(a)) unless [nil, ''].include?(self.try(a))
      end  
    end
    
    self.class.between_attributes.each do |a|
      from_a = self.try("from_#{a}".to_sym)
      to_a = self.try("to_#{a}".to_sym)
      
      if klass.columns_hash[a.to_s].type == :datetime
        from_a = Time.zone.parse(from_a) unless from_a.nil?
        to_a = Time.zone.parse(to_a) unless to_a.nil?
      end
            
      if ![nil, ''].include?(to_a) && ![nil, ''].include?(from_a)
        reln = reln.where("#{klass.table_name}.#{a} between ? and ?", from_a, to_a)
      elsif ![nil, ''].include?(to_a)
        reln = reln.where("#{klass.table_name}.#{a} < ?", to_a)
      elsif ![nil, ''].include?(from_a)
        reln = reln.where("#{klass.table_name}.#{a} > ?", from_a)
      end
    end
    
    # call the find for custom finder code implemented in subclasses
    find.nil? ? reln : reln.merge(find)
  end

  private
  
  def self.klass
    name.chomp('Searcher').constantize
  end

  def attrs
    # not all attributes are present in the model
    a = attributes.map &:to_s
    a - (a - klass.column_names) - ["approval_status"]
  end

  def self.between_attributes
    @between_attributes
  end
  
  def self.attributes
    @attributes
  end

  def attributes
    self.class.attributes
  end

  def find
    nil
  end
end
