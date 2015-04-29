require 'rails_helper'

describe VolunteerPolicy do
  subject { VolunteerPolicy.new(user, volunteer) }

  let(:volunteer) { create(:volunteer) }


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

    it { should permit(:index)          }
    it { should permit(:show)           }

    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end


  context 'para alguem do Voluntariado' do
    let(:user) { create(:user_volunteer_manager_role) }

    it { should permit(:index)          }
    it { should permit(:show)           }
    it { should permit(:create)         }
    it { should permit(:new)            }
    it { should permit(:update)         }
    it { should permit(:edit)           }
    it { should permit(:destroy)        }
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