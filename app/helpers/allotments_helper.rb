module AllotmentsHelper
  def get_deallotment_stats(allotment)
    if allotment.dealloted_at.nil?
      "** Currently alloted. **"
    else
      allotment.dealloted_at
    end
  end

  def get_user_name_by_id(id)
    user = User.find(id)
    return "N/A" if user.nil?
    user.email
  end
end
