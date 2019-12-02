"""
File to complete. Contains the agents
"""
import numpy as np
import math


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

    def update(self, state, action, reward):
        """
        Update Q-table according to previous state (observation), current state, action done and obtained reward.
        :param state: state s(t), before moving according to 'action'
        :param action: action a(t) moving from state s(t) (='state') to s(t+1)
        :param reward: reward received after achieving 'action' from state 'state'
        """
        new_state = self.mdp.observe() # To get the new current state

        # TO IMPLEMENT
        raise NotImplementedError

    def action(self, state):
        """
        Find which action to do given a state.
        :param state: state observed at time t, s(t)
        :return: optimal action a(t) to run
        """
        # TO IMPLEMENT
        raise NotImplementedError


class SARSA(Agent):
    def __init__(self, mdp):
        super(SARSA, self).__init__(mdp)

    def update(self, state, action, reward):
        """
        Update Q-table according to previous state (observation), current state, action done and obtained reward.
        :param state: state s(t), before moving according to 'action'
        :param action: action a(t) moving from state s(t) (='state') to s(t+1)
        :param reward: reward received after achieving 'action' from state 'state'
        """
        new_state = self.mdp.observe() # To get the new current state

        # TO IMPLEMENT
        raise NotImplementedError

    def action(self, state):
        """
        Find which action to do given a state.
        :param state: state observed at time t, s(t)
        :return: optimal action a(t) to run
        """
        # TO IMPLEMENT
        raise NotImplementedError


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

        # TO IMPLEMENT

        return V

    def optimal_policy_extraction(self, V):
        """2 step of policy iteration algorithm
            Return: the extracted policy
        """
        policy = np.zeros([self.mdp.env.nS, self.mdp.env.nA])
        # TO IMPLEMENT

        return policy

    def value_iteration(self):
        """This is the main function of value iteration algorithm.
            Return:
                final policy
                (optimal) state value function V
        """
        policy = np.ones([self.mdp.env.nS, self.mdp.env.nA]) / self.mdp.env.nA
        V = np.zeros(self.mdp.env.nS)

        # TO IMPLEMENT
        return policy, V


class PolicyIteration:
    def __init__(self, mdp):
        self.mdp = mdp
        self.gamma = 0.9

    def policy_evaluation(self, policy):
        """1 step of policy iteration algorithm
            Return: State Value V
        """
        V = np.zeros(self.mdp.env.nS) # intialize V to 0's

        # TO IMPLEMENT

        return np.array(V)

    def policy_improvement(self, V, policy):
        """2 step of policy iteration algorithm
            Return: the improved policy
        """
        # TO IMPLEMENT

        return policy


    def policy_iteration(self):
        """This is the main function of policy iteration algorithm.
            Return:
                final policy
                (optimal) state value function V
        """
        # Start with a random policy
        policy = np.ones([self.mdp.env.nS, self.mdp.env.nA]) / self.mdp.env.nA
        V = np.zeros(self.mdp.env.nS)

        # To implement: You need to call iteratively step 1 and 2 until convergence

        return policy, V
