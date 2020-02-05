import random
import pandas
import time
datasets = pandas.read_csv("datasets1.csv")
x=datasets.iloc[0:70,:].values
xpred=datasets.iloc[70:86,:].values
print("x",len(x))

import matplotlib.pyplot as plt
import os
from matplotlib import style
style.use('ggplot')
import numpy as np

noadder=0
nosub=0
nomul=0
nodiv=0
manhatanUnits=0
arrOpUnit=0



def multiply(a,b):
	global nomul
	nomul+=1
	# if(a!=int(a)or b!=int(b)):
	# 	return a*b
	if(a==0 or b==0):
		return 0
	# # print(a,b,"ab")
	# f_a = a-int(a)
	# f_b = b-int(b)
	# I_a = int(a)
	# I_b = int(b)
	# a=I_a
	# b=I_b
	# if(a==0 or b==0):
	# 	return((I_a+f_a)*(I_b*f_b))

	signA=a/abs(a)
	signB=b/abs(b)
	sign_d=1
	if(signA==signB):
		a=abs(a)
		b=abs(b)
		sign_d=1
	else:
		a=abs(a)
		b=abs(b)
		sign_d=-1
	afstatus =1
	bfstatus =1
	# print("a",a,"b",b)
	if a>1 and b>1:
		a=int(a*10)
		b=int(b*10)
	if(a<1):
		a=int(a*1000)
		afstatus=0
	if b<1:
		b=int(b*1000)
		bfstatus =0




	# print("a",a,"b",b)
	upperCode = "`include \"wallace16.v\"\nmodule top1;\nreg[15:0] a,b;\nwire[31:0] prod;\nwallace16 w(a,b,prod);\ninitial\nbegin\n"
	variable = "a=16'd"+str(a)+";b=16'd"+str(b)+";\n";
	lowerCode  ="end\ninitial\nbegin\n\n$monitor(\"%d\",prod);\nend\nendmodule\n"
	testBench = upperCode+variable+lowerCode

	f=open("./mac/multiplier_tb.v","w")
	f.write(testBench)
	f.close()
	os.chdir("./mac/")
	cmd = "iverilog multiplier_tb.v"
	os.system(cmd)
	cmd = "./a.out > multiplierResult.txt"
	os.system(cmd)

	f=open("multiplierResult.txt","r")
	res = f.read()
	res = res.strip()
	os.chdir("../")
	result = int(res)
	# print("result",result)
	if afstatus==0:
		result =result/1000
	if bfstatus==0:
		result =result/1000
	if afstatus==1 and bfstatus==1:
		result =result/100

	return sign_d*result

# print("mul",multiply(21.53,2.8))

def mac(a,b):
	# for each in a:
	# 	if each != int(each):
	# 		return np.sum(np.array(a))
	size = len(a)
	astatus =1
	count =0
	ain =[]
	afr =[]
	for i in a:
		ain.append(int(i))
		afr.append(i-int(i))

	upperCode = "`include \"mac.v\"\nmodule top1;\nreg [15:0] a,b;\nwire [35:0] out2;\nreg clk,reset;\nmac m1(a,b,clk,reset,out2);\ninitial\nbegin\n"
	variable =""
	for i,ival in enumerate(a):
		variable+="#10;\n"
		variable+="a="+str(ain[i])+";b="+str(b[i])+";\n"

	lowerCode = "end\ninitial\nbegin\nreset=1;\nclk =0;\na=16'd0;\nb=16'd0;\n#5 reset=0;\nforever #5 clk=~clk;\nend\ninitial\nbegin\n#"+str(((size+1)*10))+";\n$display(\"%d\",out2);\n$finish;\nend\nendmodule\n"
	testBench = upperCode+variable+lowerCode

	f=open("./mac/mac_tb.v","w")
	f.write(testBench)
	f.close()
	os.chdir("./mac/")
	cmd = "iverilog mac_tb.v"
	os.system(cmd)
	cmd = "./a.out > macResult.txt"
	os.system(cmd)

	f=open("macResult.txt","r")
	res = f.read()
	res = res.strip()
	os.chdir("../")
	return int(res)+sum(afr)



def adder(a,b):
		global noadder
		noadder+=1
		# if(a!=int(a)or b!=int(b)):
		# 	return a+b
		fstatus =1
		if(a<1 or b<1):
			a=a*10000
			b=b*10000
			fstatus =0
		else:
			a=a*100
			b=b*100

		a=int(a)
		b=int(b)

		upperCode = "`include \"fulladder64bit.v\"\nmodule top;\nreg signed [63:0] a,b;\nreg ci;\nwire signed [63:0] sum;\nwire co;\nfulladder64bit f(a,b,ci,sum,co);\ninitial\nbegin\n"
		variable = "a="+str(a)+";b="+str(b)+";ci=1'b0;\n";
		lowerCode  ="end\ninitial\nbegin\n\n$monitor(\"%d\",sum);\nend\nendmodule\n"
		testBench = upperCode+variable+lowerCode
		f=open("adder_tb.v","w")
		f.write(testBench)
		f.close()
		cmd = "iverilog "+"adder_tb.v "
		os.system(cmd)
		cmd ="./a.out > adderResult.txt"
		os.system(cmd)
		f =open("adderResult.txt","r")
		res = f.read()
		res=res.strip()
		f.close()
		val = int(res)
		if fstatus==0:
			val = val/10000
		else:
			val=val/100
		return val

# print("add",adder(10.142,10.235))

#///
def subtractor(a,b):
	global nosub
	nosub+=1
	fstatus=1
	if (a<1 or b<1):
		a*=10000
		b*=10000
		fstatus=0
	else:
		a*=10
		b*=10

	upperCode = "`include \"fullsubtractor64bit.v\"\nmodule top;\nreg signed [63:0] a,b;\nreg ci;\nwire signed [63:0] sum;\nwire co;\nfullsubtractor64bit f(a,b,ci,sum,co);\ninitial\nbegin\n"
	variable = "a="+str(a)+";b="+str(b)+";ci=1'b1;\n";
	lowerCode  ="end\ninitial\nbegin\n\n$monitor(\"%d\",sum);\nend\nendmodule\n"

	testBench = upperCode+variable+lowerCode
	f=open("adder.v","w")
	f.write(testBench)
	f.close()
	cmd = "iverilog "+"adder.v "
	os.system(cmd)
	cmd ="./a.out > adderResult.txt"
	os.system(cmd)
	f =open("adderResult.txt","r")
	res = f.read()
	res=res.strip()
	val = int(res)
	if fstatus==0:
		val=val/10000
	else:
		val=val/10
	return val
# print("sub",subtractor(0.23,0.12))
#///
#///
def divide(a,b):
	global nodiv
	nodiv+=1
	if(a==0):
		return 0
	if(b==0):
		return 0
	if(a<b):
		return a/b

	signA=a/abs(a)
	signB=b/abs(b)
	sign_d=1
	if(signA==signB):
		a=abs(a)
		b=abs(b)
		sign_d=1
	else:
		a=abs(a)
		b=abs(b)
		sign_d=-1
	remainder = a
	count=0
	while (remainder >=b):
		remainder=subtractor(remainder,b)
		count=count +1
	return (sign_d)*(count+remainder/b)

# print(adder(-5,-2),adder(0.2,0.2),adder(-2,5))
# print(subtractor(-5,-2),subtractor(0.2,0.2),subtractor(-2,5))
# print("div",divide(15.5,1.33))
#//
def arr_ops(current_centroid,original_centroid):
	global arrOpUnit
	arrOpUnit+=1
	lst=[]
	lst2=[]
	# print(current_centroid,original_centroid)
	# print(current_centroid-original_centroid)
	# rs = np.sum((current_centroid-original_centroid)/original_centroid*100.0)
	for i in range(0,len(current_centroid)):
		# z=multiply(divide(subtractor(current_centroid[i],original_centroid[i]),original_centroid[i]),100)
		z=subtractor(current_centroid[i],original_centroid[i])
		# print("sub",z,current_centroid[i]-original_centroid[i])
		z=divide(z,original_centroid[i])
		# print("div",z,((current_centroid[i]-original_centroid[i])/original_centroid[i]))
		z=multiply(z,100)
		# print("mul",z,((current_centroid[i]-original_centroid[i])/original_centroid[i])*100)
		lst.append(z)
		lst2.append(1)
	# rs = np.sum((current_centroid-original_centroid)/original_centroid*100.0)
	# print(rs,sum(lst),"diff")
	# Call mac here
	# return mac(lst,lst2)
	return adder(lst[0],lst[1])






# X = np.array([[1, 2],
#               [1.5, 1.8],
#               [5, 6 ],
#               [8, 8],
#               [1, 0.6],
#               [9,11],
#               [1,3],
#               [8,9],
#               [0,3],
#               [5,4],
#               [6,4]])
X = np.array(x)
##plt.scatter(X[:,0], X[:,1], s=150)
##plt.show()

colors = 10*["g","r","c","b","k"]


# print(adder(1,1),adder(-1,-1),adder(-1,5),adder(-5,3),adder(3,-5),adder(5,-2))
# print(subtractor(5,1),subtractor(-5,-3))
# print(divide(-5,3))
# print(multiply(-5,-5),multiply(-3,2),divide(-5,-2))
# print(multiply(2.5,2.5))


def manhatan(a,b):
	global manhatanUnits
	manhatanUnits+=1
	# print(a,b)
	# print(type(a),type(b))
	a1 =a[0]
	a2 =a[1]
	b1=b[0]
	b2=b[1]


	dist = adder((abs(subtractor(a1,b1))),(abs(subtractor(a2,b2))))


	return dist

listK =[]
class K_Medians:
	def __init__(self, k=3,tol=0.001, max_iter=50):
		self.k = k
		self.tol = tol
		self.max_iter = max_iter

	def fit(self,data):

		self.centroids = {}
		random.seed(time.clock())
		while(self.k>len(listK)):
			r=random.randint(1,len(x))
			if r not in listK: listK.append(r)
		# print("lik",listK)
		for i,ival in enumerate(listK):
			self.centroids[i] = data[ival]



		for i in range(self.max_iter):
			self.classifications = {}

			for i in range(self.k):
				self.classifications[i] = []

			for featureset in data:
				# print("h",featureset,self.centroids)
				distances = [manhatan(featureset,self.centroids[centroid]) for centroid in self.centroids]
				classification = distances.index(min(distances))
				self.classifications[classification].append(featureset)

			prev_centroids = dict(self.centroids)

			for classification in self.classifications:
				self.centroids[classification] = np.median(self.classifications[classification],axis=0)

			optimized = True

			for c in self.centroids:
				original_centroid = prev_centroids[c]
				current_centroid = self.centroids[c]
				#print(":;",current_centroid,original_centroid)
				# print("my func",summer(original_centroid,current_centroid))
				# if np.sum((current_centroid-original_centroid)/original_centroid*100.0) or arr_ops(current_centroid,original_centroid) > self.tol:
				if arr_ops(current_centroid,original_centroid) > self.tol:

					# print("this np",np.sum((current_centroid-original_centroid)/original_centroid*100.0))
					optimized = False

			if optimized:
				break

	def predict(self,data):
		distances = [manhatan(data,self.centroids[centroid]) for centroid in self.centroids]
		classification = distances.index(min(distances))
		return classification


clf = K_Medians()
clf.fit(X)

for centroid in clf.centroids:
	plt.scatter(clf.centroids[centroid][0], clf.centroids[centroid][1],marker="o", color="k", s=150, linewidths=5)

for classification in clf.classifications:
	color = colors[classification]
	for featureset in clf.classifications[classification]:
		plt.scatter(featureset[0], featureset[1], marker="x", color=color, s=150, linewidths=5)

# unknowns = np.array(xpred)
#
# for unknown in unknowns:
#    classification = clf.predict(unknown)
#    plt.scatter(unknown[0], unknown[1], marker="*", color=colors[classification])

print("add",noadder)
print("sub",nosub)
print("mul",nomul)
print("div",nodiv)
print("manh.",manhatanUnits)
print("arrOpUnit",arrOpUnit)
plt.show()
