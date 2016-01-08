package opt.test;
import shared.Instance;

import java.util.Arrays;
import java.util.Random;
import java.util.Date;

import dist.DiscreteDependencyTree;
import dist.DiscretePermutationDistribution;
import dist.DiscreteUniformDistribution;
import dist.Distribution;
import opt.EvaluationFunction;

import opt.example.*;
import opt.prob.GenericProbabilisticOptimizationProblem;
import opt.prob.MIMIC;
import opt.prob.ProbabilisticOptimizationProblem;
import shared.FixedIterationTrainer;

/**
 * 
 * author Andrew Guillory gtg008g@mail.gatech.edu
 * @version 1.0
 */
public class RasTest {
    /** The n value */
	// generate values between 0 and 2
    private static final int N = 2;

    public static void main(String[] args) {

        RasFunction ef = new RasFunction();
        // 32 bit precision * 2 variables :)
        int[] ranges = new int[64];
        
        Arrays.fill(ranges, N);
        Distribution odd = new  DiscreteUniformDistribution(ranges);
        Distribution df = new DiscreteDependencyTree(.1, ranges); 
        ProbabilisticOptimizationProblem pop = new GenericProbabilisticOptimizationProblem(ef, odd, df);
        
        int max_runs = 50;
        
        Date d1 = new Date();
        
        for ( int i =0; i < max_runs; ++i) {
        
	        MIMIC mimic = new MIMIC(200, 100, pop);
	        FixedIterationTrainer fit = new FixedIterationTrainer(mimic, 100);
	        fit.train();
	        
	        Instance d = mimic.getOptimal ();
	    	double[] xy = new double[2];
	    	ef.convertInstance (d,xy);
	    	double x = xy[0];
	    	double y = xy[1];
	    	
	    	System.out.println ("" + x + "  " + y + "  " + ef.value(d));        
	    }
        
        Date d2 = new Date();
        long elapsed_time = d2.getTime() - d1.getTime();
        System.out.println("elapsed time " + elapsed_time / 1000 + " seconds");
        
    }
}
