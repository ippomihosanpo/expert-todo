class Task < ApplicationRecord
  belongs_to :user
  REGISTRABLE_ATTRIBUTES = %i(user_id title detail priority status
                              scheduled_start_at scheduled_end_at)

  validates :user_id, presence: true
  validates :title, presence: true
  validates :detail, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  def self.list_by_user_id(user_id:)
    Task.where(user_id: user_id).order('scheduled_end_at, status')
  end

  def finish(date)
    update(status: 2, finished_at: date)
  end

end