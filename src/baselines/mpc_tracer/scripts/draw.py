#! /usr/bin/env python
# -*- coding: utf-8 -*-

'''
Author: yinuo Song
Email: 1349158395@qq.com
Description: draw a gauss
Last development: 2022.10.17
'''

import matplotlib.pyplot as plt
import numpy as np

X1 = np.random.normal(1,1,600)   #高斯分布（均值为0，方差为1，600个样本）
Y1 = np.random.normal(1,1,600)   
T1 = np.arctan2(Y1,X1)    #反正切函数，返回的是弧度
X2 = np.random.normal(4,1,300)   #高斯分布（均值为0，方差为1，300个样本）
Y2 = np.random.normal(4,1,300)   
T2 = np.arctan2(Y2,X2)    #反正切函数，返回的是弧度
X3 = np.random.normal(8,1,100)   #高斯分布（均值为0，方差为1，100个样本）
Y3 = np.random.normal(1,1,100)   
T3 = np.arctan2(Y3,X3)    #反正切函数，返回的是弧度

plt.scatter(X1,Y1,s=5,c='r',alpha=.4)   #alpha为透明度
plt.scatter(X2,Y2,s=5,c='g',alpha=.4)   
plt.scatter(X3,Y3,s=5,c='y',alpha=.4)   

plt.xlim(-5,12)
plt.ylim(-5,12)
plt.show()
