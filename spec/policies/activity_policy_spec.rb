require 'rails_helper'

describe ActivityPolicy do
  subject { ActivityPolicy.new(user, activity) }

  let(:activity) { create(:activity) }


  context 'visitante' do
    let(:user) { nil }

    it { should     permit(:index)      }
    it { should     permit(:show)       }

    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end


  context 'voluntário SEM papel de gestor de eventos global' do
    let(:user) { create(:user_volunteer_role) }

    it { should     permit(:index)      }
    it { should     permit(:show)       }

    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end


  context 'voluntário COM papel de gestor de eventos global' do
    let(:user) { create(:user_event_admin_role) }

    it { should permit(:index)      }
    it { should permit(:show)       }
    it { should permit(:create)     }
    it { should permit(:new)        }
    it { should permit(:update)     }
    it { should permit(:edit)       }
    it { should permit(:destroy)    }
  end

end