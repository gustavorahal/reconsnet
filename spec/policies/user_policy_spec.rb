require 'rails_helper'

describe UserPolicy do
  subject { UserPolicy.new(user, user_record) }

  let(:user_record) { create(:user) }


  context 'para um visitante' do
    let(:user) { nil }

    it { should_not permit(:index)      }
    it { should_not permit(:show)       }
    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end


  context 'para um voluntário' do
    let(:user) { create(:user_volunteer_role) }

    it { should_not permit(:index)      }
    it { should_not permit(:show)       }
    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end


  context 'para um admin' do
    let(:user) { create(:user_admin) }

    it { should permit(:index)          }
    it { should permit(:show)           }
    it { should permit(:create)         }
    it { should permit(:new)            }
    it { should permit(:update)         }
    it { should permit(:edit)           }
    it { should permit(:destroy)        }
  end

end