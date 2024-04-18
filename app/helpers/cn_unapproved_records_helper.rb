module CnUnapprovedRecordsHelper
  def filter_records(records)
    result = []
    CnUnapprovedRecord::CN_TABLES.each do |record|
      count = CnUnapprovedRecord.where("cn_approvable_type =?", record).count 
      result << {:record_type => record, :record_count => count}
    end
    result
  end
end
