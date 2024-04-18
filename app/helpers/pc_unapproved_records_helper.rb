module PcUnapprovedRecordsHelper
  def filter_records(records)
    result = []
    PcUnapprovedRecord::PC_TABLES.each do |record|
      count = PcUnapprovedRecord.where("pc_approvable_type =?",record).count 
      result << {:record_type => record, :record_count => count}
    end
    result
  end
end
