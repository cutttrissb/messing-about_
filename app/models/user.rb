require 'digest/sha1'

class User < ActiveRecord::Base
  
  # create_table "users", :force => true do |t|
  #   t.string   "login"
  #   t.string   "email"
  #   t.string   "password_hash"
  #   t.datetime "created_at"
  #   t.boolean  "admin",              :default => false
  #   t.integer  "posts_count",        :default => 0
  #   t.string   "signature"
  #   t.text     "bio"
  #   t.datetime "profile_updated_at"
  #   t.datetime "online_at"
  #   t.string   "avatar"
  #   t.string   "auth_token"
  #   t.datetime "auth_token_exp"
  #   t.string   "time_zone"
  #   t.string   "ban_message"
  #   t.datetime "banned_until"
  #   t.datetime "chatting_at"
  #   t.boolean  "logged_out",         :default => false
  #   t.integer  "articles_count",     :default => 0
  #   t.datetime "all_viewed_at"
  # end
  
  attr_accessible :login, :email, :password, :password_confirmation, :avatar, :signature, :bio, :time_zone
  attr_reader :password
  
  has_many :articles, :dependent => :destroy, :order => 'created_at desc'
  has_many :avatars, :dependent => :destroy, :order => 'created_at desc'
  has_many :comments, :dependent => :destroy, :order => 'created_at desc'
  has_many :events, :dependent => :destroy, :order => 'date desc'
  has_many :headers, :dependent => :destroy, :order => 'created_at desc'
  has_many :messages, :dependent => :destroy, :order => 'created_at desc'
  has_many :posts, :dependent => :destroy, :order => 'created_at desc'
  has_many :themes, :dependent => :destroy, :order => 'created_at desc'
  has_many :topics, :dependent => :destroy, :order => 'created_at desc'
  has_many :viewings, :dependent => :destroy, :order => 'updated_at desc'
  has_many :uploads, :dependent => :destroy, :order => 'created_at desc'
  has_one :current_avatar, :class_name => 'Avatar', :foreign_key => 'current_user_id', :dependent => :nullify

  has_many :subscriptions, :dependent => :destroy do
    def toggle(topic_id)
      if include?(topic_id)
        find_by_topic_id(topic_id.to_i).destroy
      else
        create :topic_id => topic_id 
      end
    end
    
    def include?(topic_or_id)
      exists? :topic_id => topic_or_id.is_a?(Topic) ? topic_or_id.id : topic_or_id.to_i
    end
  end
  
  validates_presence_of     :login, :email, :password_hash
  validates_uniqueness_of   :login, :case_sensitive => false
  validates_length_of       :login, :maximum => 25
  validates_format_of       :email, :on => :create, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates_confirmation_of :password, :on => :create
  validates_confirmation_of :password, :on => :update, :allow_blank => true
  
  before_create :set_defaults
    
  named_scope :blog_authors, :conditions => 'articles_count > 0', :order => 'articles_count desc'
  named_scope :chatting, lambda {|*args| {:conditions => ['chatting_at > ?', Time.now.utc-30.seconds], :order => 'login asc'}}
  named_scope :online, lambda {|*args| {:conditions => ['logged_out = ? and (online_at > ? or chatting_at > ?)', false, Time.now.utc-5.minutes, Time.now.utc-30.seconds], :order => 'login asc'}}
  
  def updated_at
    profile_updated_at
  end
    
  def is_online?
    return true if online_at > Time.now.utc-5.minutes unless online_at.nil?
  end
  
  def banned?
    return true if banned_until > Time.now.utc unless banned_until.nil?
  end
  
  def remove_ban
    self.ban_message = self.banned_until = nil
    self.save
  end
  
  def password=(value)
    return if value.blank?
    write_attribute :password_hash, User.encrypt(value)
    @password = value
  end
  
  def self.authenticate(login, password)
    find_by_login_and_password_hash(login, encrypt(password))
  end
  
  def self.encrypt(password)
    Digest::SHA1.hexdigest(password)
  end
    
  def set_defaults
    self.profile_updated_at = self.all_viewed_at = Time.now.utc
    self.time_zone = Setting.find(:first).time_zone
  end
  
  def to_s
    login
  end
  
end
