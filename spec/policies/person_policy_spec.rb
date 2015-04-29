require 'rails_helper'

describe PersonPolicy do
  subject { PersonPolicy.new(user, person) }

  let(:person) { create(:person) }


  context 'para um visitante' do
    let(:user) { nil }

    it { should_not permit(:index)      }
    it { should_not permit(:show)       }
    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
    it { should_not permit(:versions)   }
  end


  context 'para um voluntário' do
    let(:user) { create(:user_volunteer_role) }

    it { should permit(:index)          }
    it { should permit(:show)           }
    it { should permit(:create)         }
    it { should permit(:new)            }
    it { should permit(:update)         }
    it { should permit(:edit)           }
    it { should permit(:destroy)        }
    it { should permit(:versions)       }
  end




end