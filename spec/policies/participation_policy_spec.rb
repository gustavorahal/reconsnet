require 'rails_helper'

describe ParticipationPolicy do
  subject { ParticipationPolicy.new(user, participation) }

  let(:participation) { create(:participation) }


  context 'Visitante' do
    let(:user) { nil }

    it { should_not permit(:index)      }
    it { should_not permit(:show)       }
    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
    it { should_not permit(:record_attendance)    }
  end


  context 'Não voluntário COM papel de Participante no evento em questão' do
    let(:user) {
      user = create(:user)
      user.add_role(:participant, participation.event)
      user
    }

    it { should_not permit(:index)      }
    it { should_not permit(:show)       }
    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
    it { should_not permit(:record_attendance)    }
  end


  context 'Voluntário SEM papel de gestor de eventos global' do
    let(:user) { create(:user_volunteer_role) }

    it { should     permit(:index)      }
    it { should     permit(:show)       }

    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
    it { should_not permit(:record_attendance)    }
  end


  context 'Voluntário COM papel de gestor de eventos global' do
    let(:user) { create(:user_event_admin_role) }

    it { should permit(:index)      }
    it { should permit(:show)       }
    it { should permit(:create)     }
    it { should permit(:new)        }
    it { should permit(:update)     }
    it { should permit(:edit)       }
    it { should permit(:destroy)    }
    it { should permit(:record_attendance)    }
  end

  context 'Voluntário COM papel de gestor de eventos no evento em questão' do
    let(:user) {
      user = create(:user_volunteer_role)
      user.add_role(:event_admin, participation.event)
      user
    }

    it { should permit(:index)      }
    it { should permit(:show)       }
    it { should permit(:create)     }
    it { should permit(:new)        }
    it { should permit(:update)     }
    it { should permit(:edit)       }
    it { should permit(:destroy)    }
    it { should permit(:record_attendance)    }
  end


end