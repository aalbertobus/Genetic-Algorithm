//------------------------------BEGIN-PROCESS--------------------------------
void startProcess() {
  //convert from binary to decimal,calculate & sort (sort is minmax or maxmin and use the last column(fitness result) as reference)
  
  calculate(bintoFloat(chromosomes), sortype);
  iteration++;
}

//-------------------------------CALCULATE FUNCTION----------------------------
void calculate(float paramresults[][], String sortype_) {
  float result = 0;
  float average = 0; // to stop program

  //calculating the function
  for (int i = 0; i < paramresults.length; i++) {
    float x = paramresults[i][0];      
    //float y = paramresults[i][1];
    //float z = paramresults[i][2];
    result =   sin(radians(sqrt(abs(x)))) * -x;  //f(x)=-xsen( √∣x∣ )  absolute value of sqrt(x)x

    if (Float.isNaN(paramresults[i][0])) {
    } 
    else {// if x its different of NaN
      average += result; // adding results to average
      paramresults[i][paramresults[0].length-2] = result;
    }
  }

  printFloat(paramresults);
  int avgelements = paramresultsLim(paramresults);
  convergence = average / avgelements;  //convergence
  println("Convergence = " + average+ "/" + avgelements + " = " + convergence); 
  
  resultSort(paramresults, sortype_);  //sorting the results array
  printFloat(paramresults);
  
  if (convergence == paramresults[0][paramresults[0].length-2]) {  //stop program
    
    //Adding last result to txt file
      results[iteration] = ("Iteration = " + iteration + "     x = " + chromosomes[0][0].chromoString + "     Fitness = " + paramresults[0][paramresults[0].length-2] + "     Convergence = " + convergence);
    
    // Save to File
    saveStrings("results.txt", results);
    saveFrame("Endpopulation.jpg");
    exit();
  }
  
  matingPool(paramresults);  // do the matingPool function
  pairingChamp(paramresults);  //pairing using championship technique

  crossing(paramresults);  //converting sorted values to bin and overwrite chromosomes[][] array
  printBinary();
  
}
//--------------------------------BINARY & FLOAT CONVERTION FUNCTIONS------------------------------------
float[][] bintoFloat(Chromosome chromosomes[][]) {  //converts binary to float and storeit in paramresults[][] array
  int col = nbits*params;
  int row = nipop;
  int counterrow = 0;
  float result = 0; 
  float paramresults[][] = new float[nipop][params+2];  //creating paramresults array

  for (int i = 0; i < chromosomes.length; i++) {
    for (int j = 0; j < chromosomes[0].length; j++) {
      //check if is negative or positive checking the first number
      if (chromosomes[i][j].chromoString.charAt(0) == '1') {
        //negative! 
        result = (unbinary(chromosomes[i][j].chromoString) - pow(2, nbits-1)) * -1;
        chromosomes[i][j].diam = nbits*8;
        if (result == -0.0) {
          result = 0;
        }
        //print("[" + result + "]");
      } 
      else if (chromosomes[i][j].chromoString.charAt(0) == '0') {
        //positive
        result = unbinary(chromosomes[i][j].chromoString);
        chromosomes[i][j].diam = nbits*8;
        //print("[" + result + "]");
      } 
      else if (chromosomes[i][j].chromoString.charAt(0) == ' ') {  // if it's empty
        result = Float.NaN;
        chromosomes[i][j].diam = 0.01;
      }
      chromosomes[i][j].chromoString = "" + result;  //setting chromoString for visualization
      displayMode = "decimal";
      paramresults[i][(counterrow)] = result;

      counterrow++;
    } 
    //print("\n"); 
    if (counterrow >= paramresults[0].length-2) {
      counterrow = 0;
    }
  }
  return paramresults;
}

//------------------MATINGPOOL---------------

void matingPool(float paramresults[][]) {
  println("--------------MATING POOL----------------------");
  int looplim = paramresultsLim(paramresults);
  println("LOOPLIM = " + looplim );


  nPop = (round(random(1, looplim)));
  nGood = (round(random(1, nPop)));
  nBad = nPop-nGood;
  println("nPop = " + nPop + " nGood = " +nGood + " Nbad = " +nBad);
}


//-----------------PAIRING-------------------
void pairingChamp(float paramresults[][]) {

  //generate two parents (array indexes) and choose the less one (best one)
  //then move it to paramresults array
  for (int i = 0; i < nGood; i++) {

    //generate parents
    int parent1 = ceil((nGood*random(0, 1)));
    int parent2 = ceil((nGood*random(0, 1))); 
    float parentmin = min(parent1, parent2);  //best one parent 
    println("p1 = " +  parent1 + " p2 = " + parent2 + " min = " + parentmin);

    //copy the best parent (parentmin) in to paramresults array til nGood index
    paramresults[i][paramresults[0].length-1] = parentmin;
  }
  printFloat(paramresults);
}


//to find the limit for paramresults array 
int paramresultsLim(float paramresults[][]) {
  int looplim = paramresults.length;
  for (int i = 0; i < looplim; i++) {
    if ( Float.isNaN(paramresults[i][0])) {
      looplim = i;
    }
  }
  return looplim;
}


//--------------------------------DISPLAY & PRINT FUNCTIONS------------------------------------
//print 1 and 0 status from every Chromosome
void printBinary() {
  for (int i = 0; i < chromosomes.length; i++) {
    for (int j = 0; j < chromosomes[0].length; j++) {
      print("[" + chromosomes[i][j].chromoString + "]");
    }
    print("\n");
  }
}

//print paramResults Array
void printFloat(float paramresults[][]) {
  //printinr and running trough results array
  for (int i = 0; i < paramresults.length; i++) {
    for (int j = 0; j < paramresults[0].length; j++) {
      print("[" + paramresults[i][j] + "] ");
    } 
    print("\n");
  }
}


void displayChromosomes(String displayMode) {
  for (int i = 0; i < chromosomes.length; i++) {
    for (int j = 0; j < chromosomes[0].length; j++) {
      chromosomes[i][j].display(displayMode);
    }
  }
}


//----------------------------- ---CROSSING------------------------------------

//for clean chromosomes.chromoString array
void cleanChromosomes() {
  for (int i = 0; i < chromosomes.length; i++) {
    for (int j = 0; j < chromosomes[0].length; j++) {
      chromosomes[i][j].chromoString = " ";
    }
  }
}

//for clean paramresults array
void cleanparamresults(float[][] paramresults) {
  for (int i = 0; i < paramresults.length; i++) {
    for (int j = 0; j < paramresults[0].length; j++) {
      paramresults[i][j] =Float.NaN;
    }
  }
}


void crossing(float paramresults[][]) {  // converts float to binary and overwrite chromosomes array with the crossed values

  //printing and running trough results array
  int limit = paramresults.length;
  println("------------------CROSSING---------------------");
  // Setting limit of pairs
  for (int j = 0; j < limit; j++) {

    print("[" + paramresults[j][paramresults[0].length-1] + "] ");
    print("\n");
    if (paramresults[j][paramresults[0].length-1] == 0) {
      limit = j;  
      println("limit = " + limit);
    }
  }

  cleanChromosomes(); // cleaning chromosomes to save new ones!

  displayMode = "binary";
  int saveIndex = 0; 
  int auxlimit = 0;
  while (auxlimit < limit) {
    //Generating auxiliar random for crossing
    String auxbin = "";
    //writing on auxbin
    for (int j = 0; j < nbits; j++) {
      char status;
      if (random(0, 1) < 0.5) {  //assigning status
        status = '0';
      } 
      else {
        status = '1';
      }
      auxbin = auxbin + status;
    }
    println("axbin: " + auxbin);

    String cad1  = "";
    String cad2 = "";
    //converting from float to binary


    float index0, index1;
    index0 = paramresults[auxlimit][paramresults[0].length-1] ;
    index1 = paramresults[auxlimit+1][paramresults[0].length-1] ;

    if (index1 == 0) {  //if odd number take index 0 to cross with itself
      index1 = index0;
    }

    println("in0: " + index0);
    println("in1: " + index1);

    //setting cad1 
    if (paramresults[(int)index0-1][0] < 0) {  // if is negative number
      cad1 = "1" + binary(abs((int)paramresults[(int)index0-1][0]), nbits-1);
    } 
    else {
      cad1 = "0" + binary(abs((int)paramresults[(int)index0-1][0]), nbits-1);
    }

    //setting cad2 
    if (paramresults[(int)index1-1][0] < 0) {  // if is negative number
      cad2 = "1" + binary(abs((int)paramresults[(int)index1-1][0]), nbits-1);
    } 
    else {
      cad2 = "0" + binary(abs((int)paramresults[(int)index1-1][0]), nbits-1);
    }
    println("cad1 = " +cad1);
    println("cad2 = " +cad2);

    //Crossing with uniform cross
    //running trough auxbin string
    String auxcad1 = "";
    String auxcad2 = "";
    for (int i = 0; i < auxbin.length(); i++) {
      if (auxbin.charAt(i) == '1') {
        auxcad1 = auxcad1+cad2.charAt(i);
        auxcad2 = auxcad2+cad1.charAt(i);
      }
      else if (auxbin.charAt(i) =='0') {
        auxcad1 = auxcad1+cad1.charAt(i);
        auxcad2 = auxcad2+cad2.charAt(i);
      }
    }


    println("auxcad1 = " + auxcad1);
    println("auxbin  = " + auxbin);
    println("auxcad2 = " + auxcad2);

    auxlimit = auxlimit+2;
    //save the new two chromosomes in chromosomes array
    chromosomes[saveIndex][0].chromoString=auxcad1;
    chromosomes[saveIndex+1][0].chromoString=auxcad2;
    saveIndex = saveIndex+2;

    // y en el siguiente procedimiento reiniciar auxlimit
    println("auxlimi = " + auxlimit);
  }
  println("STOP CROSSING-------");
  int limit__;
  if (limit%2 == 0) {
    limit__ = limit;
  } 
  else {
    limit__ = limit+1;
  }
  infoText = (limit__ + " new Chromosomes");
  println(limit__ + " Chromosomes Generated by uniform Cross");
  results[iteration] = ("Iteration = " + iteration + "     x = " + chromosomes[0][0].chromoString + "     Fitness = " + paramresults[0][paramresults[0].length-2] + "     Convergence = " + convergence);
  cleanparamresults(paramresults); //cleaning paramresults to save new values
  
    //printFloat(paramresults);
}


//--------------------------------SORTING FUNCTIONS------------------------------------

void resultSort(float paramresults[][], String sortype) {
  int row = paramresults.length;  
  int col = paramresults[0].length;
  float [] aux = new float [col];

  if (sortype == "minmax") {   //order from min to max 
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < row-1; j++) {
        if (paramresults[j][(paramresults[0].length -2)] > paramresults[j+1][(paramresults[0].length -2)]) {
          for (int k = 0; k < col; k++) {
            aux[k] = paramresults[j][k];
            paramresults[j][k] = paramresults[j+1][k];
            paramresults[j+1][k] = aux[k];
          }
        }
      }
    }
    println("sorting from min to max...");
  } 
  else if (sortype == "maxmin") {   //order from max to min
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < row-1; j++) {
        if (paramresults[j][(paramresults[0].length -2)] < paramresults[j+1][(paramresults[0].length -2)]) {
          for (int k = 0; k < col; k++) {
            aux[k] = paramresults[j][k];
            paramresults[j][k] = paramresults[j+1][k];
            paramresults[j+1][k] = aux[k];
          }
        }
      }
    }
    println("sorting from max to min...");
  }
  else {
    println("sort string needs to be 'minmax' or 'maxmin' in order to sort");
  }
}

