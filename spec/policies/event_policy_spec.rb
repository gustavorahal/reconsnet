require 'rails_helper'

describe EventPolicy do
  subject { EventPolicy.new(user, event) }

  let(:event) { create(:event) }


  context 'visitante' do
    let(:user) { nil }

    it { should     permit(:index)      }
    it { should     permit(:show)       }

    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
    it { should_not permit(:emails)     }
    it { should_not permit(:attendance) }
    it { should_not permit(:archive)    }
    it { should_not permit(:unarchive)  }
  end


  context 'não voluntário COM papel de Participante no evento em questão' do
    let(:user) {
      user = create(:user)
      user.add_role(:participant, event)
      user
    }

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
    it { should     permit(:emails)     }
    it { should     permit(:attendance) }

    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }

    it { should_not permit(:archive)    }
    it { should_not permit(:unarchive)  }
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
    it { should permit(:emails)     }
    it { should permit(:attendance) }
    it { should permit(:archive)    }
    it { should permit(:unarchive)  }
  end


  context 'Voluntário COM papel de gestor de eventos no evento em questão' do
    let(:user) {
      user = create(:user_volunteer_role)
      user.add_role(:event_admin, event)
      user
    }

    it { should permit(:index)      }
    it { should permit(:show)       }
    it { should permit(:update)     }
    it { should permit(:edit)       }
    it { should permit(:emails)     }
    it { should permit(:attendance) }

    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:destroy)    }
    it { should_not permit(:archive)    }
    it { should_not permit(:unarchive)  }
  end

end