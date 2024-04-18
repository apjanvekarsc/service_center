class EmailSetup < ActiveRecord::Base

	include Approval2::ModelAdditions
	
	belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
	belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'


	validates_presence_of :service_name,:app_id,:customer_id,:domain_name
	
	validates_format_of :domain_name, with: /\A+@([\w\-]+\.)+([A-Z]{2,4})\Z/i,message: "Not a valid Domain"

	validates_uniqueness_of :app_id,:customer_id,:service_name, :scope => [:app_id,:service_name,:customer_id,:approval_status],message: "Record already present"
	validates_format_of :app_id, with: /\A[a-zA-Z0-9 ]*\z/,message: "Not a valid App ID", length: { maximum: 255 }
	validates_format_of :customer_id, with: /\A[a-zA-Z0-9 ]*\z/,message: "Not a valid Customer ID", length: { maximum: 255 }
	validates_format_of :customer_name, with: /\A[a-zA-Z0-9 ]*\z/,message: "Not a valid Customer Name", length: { maximum: 255 }
	validate :any_email_present?

	def any_email_present?
		if [self.email1, self.email2, self.email3, self.email4, self.email5].reject(&:blank?).size == 0
			self.errors.add(:email_error_base, "Please enter atleast one Email Address")
		end
			
		if self.email1.present?
			errors.add(:email1, "Not a Valid Domain Name") if check_domain(self.domain_name,self.email1) == false
			validates_format_of :email1, with: /\A([\w\.-]+)@([\w\-]+\.)+([A-Z]{2,4})\Z/i,message: "Not a valid Email Address", length: { maximum: 100 }
		end
			
		if self.email2.present?
			errors.add(:email2, "Not a Valid Domain Name") if check_domain(self.domain_name,self.email2) == false
			validates_format_of :email2, with: /\A([\w\.-]+)@([\w\-]+\.)+([A-Z]{2,4})\Z/i,message: "Not a valid Email Address", length: { maximum: 100 }
		end
			
		if self.email3.present?
			errors.add(:email3, "Not a Valid Domain Name") if check_domain(self.domain_name,self.email3) == false
			validates_format_of :email3, with: /\A([\w\.-]+)@([\w\-]+\.)+([A-Z]{2,4})\Z/i,message: "Not a valid Email Address", length: { maximum: 100 }
		end
			
		if self.email4.present?
			errors.add(:email4, "Not a Valid Domain Name") if check_domain(self.domain_name,self.email4) == false
			validates_format_of :email4, with: /\A([\w\.-]+)@([\w\-]+\.)+([A-Z]{2,4})\Z/i,message: "Not a valid Email Address", length: { maximum: 100 }
		end
			
		if self.email5.present?
			errors.add(:email5, "Not a Valid Domain Name") if check_domain(self.domain_name,self.email5) == false
			validates_format_of :email5, with: /\A([\w\.-]+)@([\w\-]+\.)+([A-Z]{2,4})\Z/i,message: "Not a valid Email Address", length: { maximum: 100 }
		end
	end

	def email1_content
		data = self.email1.present? ? self.email1 : "-"
	end

	def email2_content
		data = self.email2.present? ? self.email2 : "-"
	end

	def email3_content
		data = self.email3.present? ? self.email3 : "-"
	end

	def email4_content
		data = self.email4.present? ? self.email4 : "-"
	end

	def email5_content
		data = self.email5.present? ? self.email5 : "-"
	end

	def self.data_search(service_name,app_id,customer_id)
		if service_name == "all"
			@records = EmailSetup.where(is_active: "T").all
		else
			@records = EmailSetup.where(service_name: service_name,is_active: "T") if service_name.present?
			@records = EmailSetup.where(app_id: app_id,is_active: "T") if app_id.present?
			@records = EmailSetup.where(customer_id: customer_id,is_active: "T") if customer_id.present?
		end
		
		return @records
	end

	def check_domain(domain,email_id)
		if domain_name.present?
			mail_id_domain = email_id.split("@")
			d = domain_name.split("@")

			if domain_name.split("@")[1] == mail_id_domain[1]
				return true
			else
				return false
			end
		else
			return false
		end
	end

end