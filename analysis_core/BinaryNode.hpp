//
//  AONode.hpp
//  mm
//
//  Created by Anna-Monica  on 8/1/18.
//  Copyright © 2018 Anna-Monica. All rights reserved.
//

#ifndef BinaryNode_hpp
#define BinaryNode_hpp

#include <stdio.h>
#include <math.h>
#include "Node.h"
//takes care of Arithmetical Operators, Logical Operators, and Comparison Operators
class BinaryNode : public Node{
private:
    double (*f)(double, double);
public:
    BinaryNode(double (*func)(double, double), Node* l, Node* r, std::string s){
        f=func;
        symbol=s;
        left=l;
        right=r;
    }

    virtual void getParticles(std::vector<myParticle *>* particles) override{
        left->getParticles(particles);
        right->getParticles(particles);
        
    }

    virtual void getParticlesAt(std::vector<myParticle *>* particles,int index) override{
        left->getParticlesAt(particles,index);
        right->getParticlesAt(particles,index);
    }
    virtual void Reset() override{
        left->Reset();
        right->Reset();
    }
    virtual double evaluate(AnalysisObjects* ao) override{
            return (*f)(left->evaluate(ao),right->evaluate(ao));
    }
    virtual ~BinaryNode() {
//        if (left!=NULL) delete left;
//        if (right!=NULL) delete right;
    }

};

double add(double left, double right) {
    return left + right;
}

double mult(double left, double right) {
    return left * right;
}

double sub(double left, double right) {
    return left - right;
}

double div(double left, double right) {
    return left / right;
}

//double power ALREADY EXIST
double lt(double left, double right){
    return (double)(left<right);
}
double le(double left, double right){
    return (double)(left<=right);
}
double ge(double left, double right){
    return (double)(left>=right);
}
double gt(double left, double right){
    return (double)(left>right);
}
double eq(double left, double right){
    return (double)(left==right);
}
double ne(double left, double right){
    return (double)(left!=right);
}
double LogicalAnd(double left, double right){
    return (double)(left&&right);
}
double LogicalOr(double left, double right){
    return (double)(left||right);
}
double LogicalNot(double condition, double condition1){
	return (double)(!(condition));
}
double mnof(double left, double right){
    return (double)( (left<right)*left +(left>right)*right );
}
double mxof(double left, double right){
    return (double)( (left>right)*left +(left<right)*right );
}


//if CONDITION-> later
#endif /* AONode_hpp */
