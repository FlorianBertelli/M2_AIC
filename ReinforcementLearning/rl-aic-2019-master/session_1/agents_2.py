"""
File to complete. Contains the agents
"""
import numpy as np
import math
import random

class Agent(object):
    """Agent base class. DO NOT MODIFY THIS CLASS
    """

    def __init__(self, mdp):
        super(Agent, self).__init__()
        # Init with a random policy
        self.policy = np.zeros((4, mdp.env.observation_space.n)) + 0.25
        self.mdp = mdp
        self.discount = 0.9

        # Intialize V or Q depends on your agent
        # self.V = np.zeros(self.mdp.env.observation_space.n)
        # self.Q = np.zeros((4, self.mdp.env.observation_space.n))

    def update(self, observation, action, reward):
        # DO NOT MODIFY. This is an example
        pass

    def action(self, observation):
        # DO NOT MODIFY. This is an example
        return self.mdp.env.action_space.sample()


class QLearning(Agent):
    def __init__(self, mdp):
        super(QLearning, self).__init__(mdp)
        self.Q = np.zeros((4,mdp.env.observation_space.n))
        self.learning_rate = 0.01
        self.eps = 0.05
    def update(self, state, action, reward):
        """
        Update Q-table according to previous state (observation), current state, action done and obtained reward.
        :param state: state s(t), before moving according to 'action'
        :param action: action a(t) moving from state s(t) (='state') to s(t+1)
        :param reward: reward received after achieving 'action' from state 'state'
        """
        new_state = self.mdp.observe() # To get the new current state

        learning_rate = self.learning_rate

        self.Q[action,state] = self.Q[action,state] * (1 - learning_rate) + \
        learning_rate*(reward + self.discount * np.max(self.Q[ : , new_state]) ) 

        

    def action(self, state):
        """
        Find which action to do given a state.
        :param state: state observed at time t, s(t)
        :return: optimal action a(t) to run
        """
        if (random.random() > 1- self.eps):
            return(random.randint(0,3))
        else:
            return(np.argmax(self.Q[:, state]))


class SARSA(Agent):
    def __init__(self, mdp):
        super(SARSA, self).__init__(mdp)
        self.Q = np.zeros((4,mdp.env.observation_space.n))
        self.learning_rate = 0.1
        self.eps = 0.05
    def update(self, state, action, reward):
        """
        Update Q-table according to previous state (observation), current state, action done and obtained reward.
        :param state: state s(t), before moving according to 'action'
        :param action: action a(t) moving from state s(t) (='state') to s(t+1)
        :param reward: reward received after achieving 'action' from state 'state'
        """

        new_state = self.mdp.observe() # To get the new current state
        learning_rate = self.learning_rate
        self.Q[action,state] = self.Q[action,state] * (1 - learning_rate) + \
        learning_rate*(reward + self.discount * (self.Q[ action, new_state]) ) 

    def action(self, state):
        """
        Find which action to do given a state.
        :param state: state observed at time t, s(t)
        :return: optimal action a(t) to run
        """
        if (random.random() > 1- self.eps):
            return(random.randint(0,3))
        else:
            return(np.argmax(self.Q[:, state]))



class ValueIteration:
    def __init__(self, mdp):
        self.mdp = mdp
        self.gamma = 0.9

    def optimal_value_function(self):
        """1 step of value iteration algorithm
            Return: State Value V
        """
        # Intialize random V
        V = np.zeros(self.mdp.env.nS)

        max_iterations = 10000
        eps = 1e-30
        for i in range(max_iterations):
            prev_v = (V)
            for s in range(self.mdp.env.nS):
                q_sa = [sum([p*(r + self.gamma * prev_v[s_prime]) for p, s_prime, r, _ in self.mdp.env.P[s][a]]) for a in range(self.mdp.env.nA)] 
                V[s] = max(q_sa)
            if (np.sum(np.abs(prev_v - V)) <= eps):
                return V
        return V

    def optimal_policy_extraction(self, V):
        """2 step of policy iteration algorithm
            Return: the extracted policy
        """
        policy = np.zeros((self.mdp.env.nS, self.mdp.env.nA)) 
        for s in range(self.mdp.env.nS):
            Q_sa = np.zeros(self.mdp.env.nA)
            for a in range(self.mdp.env.nA):
                for next_sr in self.mdp.env.P[s][a]:
                    p, s_prime, r, _ = next_sr
                    Q_sa[a] += (p * (r + self.gamma * V[s_prime]))
            policy[s][np.argmax(Q_sa)] = 1
        return(policy)

    def value_iteration(self):
        """This is the main function of value iteration algorithm.
            Return:
                final policy
                (optimal) state value function V
        """
        policy = np.ones([self.mdp.env.nS, self.mdp.env.nA]) / self.mdp.env.nA
        V = np.zeros(self.mdp.env.nS)
        
        
   
        V_opt = self.optimal_value_function()
        policy = self.optimal_policy_extraction(V_opt)
        
        return policy, V


class PolicyIteration:
    def __init__(self, mdp):
        self.mdp = mdp
        self.gamma = 0.9

    def policy_eval(self, policy, discount_factor=0.9, theta=0.00001):

        # Start with a random (all 0) value function
        V = np.zeros(self.mdp.env.nS)
        while True:
            delta = 0
            # For each state, perform a "full backup"
            for s in range(self.mdp.env.nS):
                v = 0
                # Look at the possible next actions
                for a, action_prob in enumerate(policy[s]):
                    # For each action, look at the possible next states...
                    for  prob, next_state, reward, done in self.mdp.env.P[s][a]:
                        # Calculate the expected value
                        v += action_prob * prob * (reward + discount_factor * V[next_state])
                # How much our value function changed (across any states)
                delta = max(delta, np.abs(v - V[s]))
                V[s] = v
            # Stop evaluating once our value function change is below a threshold
            if delta < theta:
                break
        return (V)

    def policy_improvement(self,  discount_factor=0.9):


        def one_step_lookahead(state, V):

                A = np.zeros(self.mdp.env.nA)
                for a in range(self.mdp.env.nA):
                    for prob, next_state, reward, done in self.mdp.env.P[state][a]:
                        A[a] += prob * (reward + discount_factor * V[next_state])
                return A

        # Start with a random policy
        policy = np.ones([self.mdp.env.nS, self.mdp.env.nA]) / self.mdp.env.nA

        while True:
            # Evaluate the current policy
            V = self.policy_eval(policy, discount_factor)

            # Will be set to false if we make any changes to the policy
            policy_stable = True

            # For each state...
            for s in range(self.mdp.env.nS):
                # The best action we would take under the current policy
                chosen_a = np.argmax(policy[s])

                # Find the best action by one-step lookahead
                # Ties are resolved arbitarily
                action_values = one_step_lookahead(s, V)
                best_a = np.argmax(action_values)

                # Greedily update the policy
                if chosen_a != best_a:
                    policy_stable = False
                policy[s] = np.eye(self.mdp.env.nA)[best_a]

            # If the policy is stable we've found an optimal policy. Return it
            if policy_stable:
                return policy, V


    def policy_iteration(self):
        """This is the main function of policy iteration algorithm.
            Return:
                final policy
                (optimal) state value function V
        """
        # Start with a random policy
        policy = np.ones([self.mdp.env.nS, self.mdp.env.nA]) / self.mdp.env.nA
        V = np.zeros(self.mdp.env.nS)
        
        policy, v = self.policy_improvement()
        

        return policy, V