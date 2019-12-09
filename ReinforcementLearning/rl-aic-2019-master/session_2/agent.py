import numpy as np
import random
random.seed(0)
np.random.seed(0)


"""
Contains the definition of the agent that will run in an
environment.
"""

class RandomAgent:
    def __init__(self):
        """Init a new agent.
        """

    def choose(self):
        """Acts in the environment.

        returns the chosen action.
        """
        return np.random.randint(0, 10)

    def update(self, action, reward):
        """Receive a reward for performing given action on
        given observation.

        This is where your agent can learn.
        """
        pass

class epsGreedyAgent:
    def __init__(self):
        self.A = [0,1,2,3,4,5,6,7,8,9]
        self.n = 1
        self.c = 0.5
        self.d = 0.5
        self.average_rewards = [0 for i in range(len(self.A))]
        self.nb_action = [0 for i in range (len(self.A))]
        self.esp = 0

    def choose(self):
        self.eps = min(1,(self.c*10)/(self.d**2 * self.n))
        if (random.random() > 1- self.eps):
           return(random.randint(0,9))
        else:
            return(np.argmax(self.average_rewards))

    def update(self, action, reward):
        self.n +=1
        self.nb_action[action] +=1
        self.average_rewards[action]= self.average_rewards[action] * (self.nb_action[action]-1)/(self.nb_action[action]) + reward/self.nb_action[action]


class BesaAgent():
    # https://hal.archives-ouvertes.fr/hal-01025651v1/document
    def __init__(self):
        self.A = [0,1,2,3,4,5,6,7,8,9]
        self.nb_action=[0 for i in range(len(self.A))]
        self.average_rewards = [0 for i in range(len(self.A))]

    def compare(self):

    def choose(self):
    	for i in range(0,2,len(self.A)-1):
    		if(self.average_rewards[i]> self.average_rewards[i+1]):
    			random.sample(self.average_rewards)


    def update(self, action, reward):
        raise NotImplemented

class SoftmaxAgent:
    # https://www.cs.mcgill.ca/~vkules/bandits.pdf

	def __init__(self):
	    self.A = [0,1,2,3,4,5,6,7,8,9]
	    self.average_rewards = [0 for i in range(len(self.A))]
	    self.nb_action = [0 for i in range (len(self.A))]
	    self.n=0
	    self.proba = [0 for i in range(len(self.A))]
	    self.to = 0.01


	def choose(self):
		if(self.n>=10):
			return np.random.choice(self.A, p=self.proba)
		else:
			return self.n	    	

	def update(self, action, reward):
	    self.n +=1
	    self.nb_action[action] +=1
	    self.average_rewards[action]= self.average_rewards[action] * (self.nb_action[action]-1)/(self.nb_action[action]) + reward/self.nb_action[action]
	    if(self.n >= 10):
	    	self.proba = np.exp(np.array(self.average_rewards)/self.to) / np.sum(np.exp(np.array(self.average_rewards)/self.to))


class UCBAgent:
    # https://homes.di.unimi.it/~cesabian/Pubblicazioni/ml-02.pdf
    def __init__(self):
        self.A = [0,1,2,3,4,5,6,7,8,9]
        self.average_rewards = [0 for i in range(len(self.A))]
        self.nb_action = [0 for i in range (len(self.A))]
        self.n=0


    def choose(self):
    	if(self.n<10):
    		return(self.n)
    	else:
        	return(np.argmax(self.average_rewards + (2*np.log(self.n)/self.nb_action)**(1/2)))

    def update(self, action, reward):
        self.n +=1
        self.nb_action[action] +=1
        self.average_rewards[action]= self.average_rewards[action] * (self.nb_action[action]-1)/(self.nb_action[action]) + reward/self.nb_action[action]

class ThompsonAgent:
    # https://en.wikipedia.org/wiki/Thompson_sampling
    def __init__(self):
        self.A = [0,1,2,3,4,5,6,7,8,9]
        self.alpha = [100 for i in range(len(self.A))]
        self.beta = [1000 for i in range(len(self.A))]
        print(self.alpha)
        for i in range(len(self.alpha)):
        	if(self.alpha[i]>self.beta[i]):
        		self.alpha[i],self.beta[i]= self.beta[i],self.alpha[i]
        self.k=0

    def choose(self):
        self.theta = np.random.beta(self.alpha, self.beta)
        #print(self.theta)
        self.k = self.A[np.argmax(self.theta)]
        return(self.k)

    def update(self, a, r):
        self.alpha[a] += r
        self.beta[a] += 1 - r 
       
  

class KLUCBAgent:
    # See: https://hal.archives-ouvertes.fr/hal-00738209v2
    def __init__(self):
        self.A = [0,1,2,3,4,5,6,7,8,9]

    def choose(self):
        raise NotImplemented

    def update(self, a, r):
        raise NotImplemented

# Choose which Agent is run for scoring
Agent = RandomAgent
