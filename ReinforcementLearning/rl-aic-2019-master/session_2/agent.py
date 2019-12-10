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
        self.c = 0.1
        self.d = 0.5
        self.average_rewards = [0 for i in range(len(self.A))]
        self.nb_action = [0 for i in range (len(self.A))]
        self.esp = 0

    def choose(self):
        self.eps = min(1,(self.c*len(self.A))/(self.d**2 * self.n))
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
        self.rewards = [[0] for i in range(10)]

    def besa(self, a, b):
        if len(self.rewards[a]) > len(self.rewards[b]):
            mini, maxi = b, a
        else:
            mini, maxi = a, b
        submaxi = np.random.choice((self.rewards[maxi]), len(self.rewards[mini]))
        mini_average = np.average(np.array(self.rewards[mini]))
        maxi_average = np.average(submaxi)
        if mini_average >= maxi_average:
            return mini
        else:
            return maxi

    def rec(self, start, end):
        if end - start == 1:
            return start
        if end - start == 2:
            return self.besa(start, start+1)
        return self.besa(self.rec(start, (start + end)//2), self.rec((start+end)//2, end))

    def choose(self):
        return self.rec(0, 10)

    def update(self, action, reward):
        self.rewards[action].append(reward)

# class BesaAgent():
#     # https://hal.archives-ouvertes.fr/hal-01025651v1/document
#     def __init__(self, A=[0,1,2,3,4,5,6,7,8,9] , nb_action =[0 for i in range(len(self.A))] ,average_rewards=[0 for i in range(len(self.A))] , reward_history =[[] for i in range(len(self.A))]):
#         self.A = A
#         self.nb_action=nb_action
#         self.average_rewards = average_rewards
#         self.reward_history = reward_history
  
#     def besa_two_actions(A, B);
#     	A_ = A
#     	B_ = B
#     	N = min((len(A),len(B)))
#     	if(N = len(A)):
#     		B_ = random.sample(B,N)
#     	else:
#     		A_ = random.sample(A,N)
#     	mean_A = np.mean(A_)
#     	mean_B = np.mean(B_)

#     	if(mean_A)> mean_B:
#     		return(A)
#     	else:
#     		return(B)


#     def choose(self):
#     	if len(self.A==1):
#     		return(self.A[0])
#     	if len(self.A ==2):
#     		besa_two_actions(A[0], A[1])
#     	else:
#     		choose()
#     	# best_round1 = []
#     	# for i in range(0,2,len(self.A)-1):
#     	# 	if(len(self.reward_history[i])> len(self.reward_history[i+1])):
#     	# 		rew_i = np.sum(random.sample(self.reward_history[i],len(self.reward_history[i+1])))/(len(self.reward_history[i+1]))
#     	# 		rew_i1 = np.sum(self.reward_history[i+1])/len(self.reward_history[i+1])
#     	# 	if(len(self.reward_history[i])<= len(self.reward_history[i+1])):
#     	# 		rew_i1 =np.sum(random.sample(self.reward_history[i+1],len(self.reward_history[i])))/(len(self.reward_history[i]))
#     	# 		rew_i = np.sum(self.reward_history[i])/len(self.reward_history[i])
#     	# 	if(rew_i1 > rew_i):
#     	# 		best_round1.append()


#     def update(self, action, reward):
        

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
Agent = UCBAgent

