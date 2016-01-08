package opt.example;

import shared.Instance;
import opt.EvaluationFunction;


/**
 * A traveling salesman evaluation function that works with
 * routes that are encoded as sorts.  That is the route
 * is the permutaiton of indices found by sorting the data.
 * @author Andrew Guillory gtg008g@mail.gatech.edu
 * @version 1.0
 */
public class RasFunction implements EvaluationFunction {

    /**
     * Make a new traveling salesman evaluation function
     * @param points the points at which the cities are located
     */

    public RasFunction() {}

    public void convertInstance (Instance d, double[] xy)
    {
//    	 get x and y
    	double[] ddata = new double[d.size()];
            for (int i = 0; i < ddata.length; i++) {
                ddata[i] = d.getContinuous(i);
            }
            
            int ix=0,iy=0;
            
            for ( int i =0; i < 32; ++i )
            {
            	ix |= (ddata[i] < 1 ? 0 : 1) << i;
            	iy |= (ddata[i+32] < 1 ? 0 : 1) << i;
            }
            
        double maxi = Integer.MAX_VALUE;
        xy[0] = ix;
        xy[1]= iy;
        
    	xy[0] = xy[0] / maxi * 20.0;
    	xy[1] = xy[1] / maxi * 20.0;
    }

    
    /**
     * @see opt.EvaluationFunction#value(opt.OptimizationData)
     */
    public double value(Instance d) {
        
	double[] xy = new double[2];
	convertInstance (d,xy);
	
	double x = xy[0];
	double y = xy[1];

	return -(20 + 3 * (x*x + y*y) -10*(Math.cos(2*Math.PI*x)+Math.cos(2*Math.PI*y)));

    }

}
