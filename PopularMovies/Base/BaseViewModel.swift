//
//  BaseViewModel.swift
//  PopularMovies
//
//  Created by Cem Kazım on 12.11.2023.
//

protocol BaseViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class BaseViewModel {}
