package opt.test;

import java.util.Arrays;
import java.util.Date;

import dist.DiscreteDependencyTree;
import dist.DiscreteUniformDistribution;
import dist.Distribution;

import opt.DiscreteChangeOneNeighbor;
import opt.EvaluationFunction;
import opt.GenericHillClimbingProblem;
import opt.HillClimbingProblem;
import opt.NeighborFunction;
import opt.RandomizedHillClimbing;
import opt.SimulatedAnnealing;
import opt.example.*;
import opt.ga.CrossoverFunction;
import opt.ga.DiscreteChangeOneMutation;
import opt.ga.GenericGeneticAlgorithmProblem;
import opt.ga.GeneticAlgorithmProblem;
import opt.ga.MutationFunction;
import opt.ga.StandardGeneticAlgorithm;
import opt.ga.UniformCrossOver;
import opt.prob.GenericProbabilisticOptimizationProblem;
import opt.prob.MIMIC;
import opt.prob.ProbabilisticOptimizationProblem;
import shared.FixedIterationTrainer;

/**
 * 
 * @author Andrew Guillory gtg008g@mail.gatech.edu
 * @version 1.0
 */
public class CountOnesTest {
    /** The n value */
    private static final int N = 80;
    
    public static void main(String[] args) {
        int[] ranges = new int[N];
        Arrays.fill(ranges, 2);
        EvaluationFunction ef = new CountOnesEvaluationFunction();
        Distribution odd = new DiscreteUniformDistribution(ranges);
        NeighborFunction nf = new DiscreteChangeOneNeighbor(ranges);
        MutationFunction mf = new DiscreteChangeOneMutation(ranges);
        CrossoverFunction cf = new UniformCrossOver();
        Distribution df = new DiscreteDependencyTree(.1, ranges); 
        HillClimbingProblem hcp = new GenericHillClimbingProblem(ef, odd, nf);
        GeneticAlgorithmProblem gap = new GenericGeneticAlgorithmProblem(ef, odd, mf, cf);
        ProbabilisticOptimizationProblem pop = new GenericProbabilisticOptimizationProblem(ef, odd, df);
        
        RandomizedHillClimbing rhc;      
        FixedIterationTrainer fit;
        
        
        // 200
        Date d1 = new Date();
        int maxruns = 100;
        double value =0;
        
        for ( int i =0; i < maxruns; ++i) {
        	
        rhc = new RandomizedHillClimbing(hcp);      
        fit = new FixedIterationTrainer(rhc, 200);
        fit.train();
        
        value += ef.value(rhc.getOptimal());
        
        }
        System.out.println( value / maxruns );
        
        Date d2 = new Date();
        long elapsed_time = d2.getTime() - d1.getTime();
        System.out.println("elapsed time " + elapsed_time + " seconds");
        
        
        // 200
        d1 = new Date();
        maxruns = 100;
        value =0;
        
        for ( int i =0; i < maxruns; ++i) {
        	
        
        SimulatedAnnealing sa = new SimulatedAnnealing(100, .95, hcp);
        fit = new FixedIterationTrainer(sa, 200);
        fit.train();
        value += ef.value(sa.getOptimal());
        
        }
        System.out.println( value / maxruns );
        
        d2 = new Date();
        elapsed_time = d2.getTime() - d1.getTime();
        System.out.println("elapsed time " + elapsed_time  + " seconds");
        
        
        // 60000
        d1 = new Date();
        maxruns = 100;
        value =0;
        
        for ( int i =0; i < maxruns; ++i) {
        
        StandardGeneticAlgorithm ga = new StandardGeneticAlgorithm(20, 20, 0, gap);
        fit = new FixedIterationTrainer(ga, 300);
        fit.train();
        value += ef.value(ga.getOptimal());
        
        }
        System.out.println( value / maxruns );
        d2 = new Date();
        elapsed_time = d2.getTime() - d1.getTime();
        System.out.println("elapsed time " + elapsed_time + " seconds");
        
        
        // 5000
        d1 = new Date();
        maxruns = 10;
        value =0;
        
        for ( int i =0; i < maxruns; ++i) {
        
        MIMIC mimic = new MIMIC(50, 10, pop);
        fit = new FixedIterationTrainer(mimic, 100);
        fit.train();
        value += ef.value(mimic.getOptimal());
        
        }
        System.out.println( value / maxruns );
        d2 = new Date();
        elapsed_time = d2.getTime() - d1.getTime();
        System.out.println("elapsed time " + elapsed_time  + " seconds");
        
    }
}