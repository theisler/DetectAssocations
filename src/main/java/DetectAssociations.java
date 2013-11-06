package theisler.detectassociations;

import java.io.IOException;
import java.util.*;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.conf.*;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapred.*;
import org.apache.hadoop.util.*;

public class DetectAssociations {
	public static class Map extends MapReduceBase implements Mapper<LongWritable, Text, Text, IntWritable> {
		private final static IntWritable one = new IntWritable(1);
		private Text word = new Text();
	
		public void map(LongWritable key, Text value, OutputCollector<Text, IntWritable> output, Reporter reporter) 
				throws IOException {
			String line = value.toString();
			// TODO: Put CSV parser in here
			// TODO: Extract all the field data (must be integers at this point)
			// TODO: Emit every combination of columns taken two at a time 
			
			
			
			/*StringTokenizer tokenizer = new StringTokenizer(line);
			while (tokenizer.hasMoreTokens()) {
				word.set(tokenizer.nextToken());
				output.collect(word, one);
			}
			*/
		}
	}
	
	
	public static class Reduce extends MapReduceBase implements Reducer<Text, IntWritable, Text, IntWritable> {
		public void reduce(Text key, Iterator<IntWritable> values, OutputCollector<Text, IntWritable> output, Reporter reporter) throws IOException {
			int sum = 0;
			HashMap coll = new HashMap();
			// TODO: Build an input map. Input data will be sorted so gather everything with the same label
			// TODO: ... then invoke the MINE algorithm for the data under one label
			// TODO: Then serialize the MINE results using the label for the data gathered
			
		 	while (values.hasNext()) {
//			 	sum += values.next().get();
		 		coll.put(key, value);
		 	}
		 	output.collect(key, new IntWritable(sum));
		 }
	}
	
	
	public static void main(String[] args) throws Exception {
		JobConf conf = new JobConf(DetectAssociations.class);
		conf.setJobName("DetectAssociations");

		conf.setOutputKeyClass(Text.class);
		conf.setOutputValueClass(Text.class);
	
		conf.setMapperClass(Map.class);
		conf.setCombinerClass(Reduce.class);
		conf.setReducerClass(Reduce.class);
	
		conf.setInputFormat(TextInputFormat.class);
		conf.setOutputFormat(TextOutputFormat.class);
	
		FileInputFormat.setInputPaths(conf, new Path(args[0]));
		FileOutputFormat.setOutputPath(conf, new Path(args[1]));
	
		JobClient.runJob(conf);
	}
}
