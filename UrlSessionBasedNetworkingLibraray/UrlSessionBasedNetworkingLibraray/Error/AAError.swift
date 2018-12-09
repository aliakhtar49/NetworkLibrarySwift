//
//  AAError.swift
//  UrlSessionBasedNetworkingLibraray
//
//  Created by Ali Akhtar on 18/11/2018.
//  Copyright © 2018 Ali Akhtar. All rights reserved.
//

import Foundation

public enum CustomError {
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299 : return .success
        case 401...500 : return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599 : return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    enum NetworkResponse: String {
        case success
        case authenticationError = "You need to be authenticated first."
        case badRequest = "Bad Request"
        case outdated = "The url you requested is outdated."
        case failed = "Network request failed"
        case noData = "Response returned with no data to decode. "
        case unableToDecode = "We could not decode the response"
        
    }
    public enum AAError: Error {
        /// The underlying reason the parameter encoding error occurred.
        ///
        /// - missingURL:                 The URL request did not have a URL to encode.
        /// - jsonEncodingFailed:         JSON serialization failed with an underlying system error during the
        ///                               encoding process.
        /// - propertyListEncodingFailed: Property list serialization failed with an underlying system error during
        ///                               encoding process.
        public enum ParameterEncodingFailureReason {
            case missingURL
            case jsonEncodingFailed(error: Error)
            case propertyListEncodingFailed(error: Error)
        }
        
        /// The underlying reason the multipart encoding error occurred.
        ///
        /// - bodyPartURLInvalid:                   The `fileURL` provided for reading an encodable body part isn't a
        ///                                         file URL.
        /// - bodyPartFilenameInvalid:              The filename of the `fileURL` provided has either an empty
        ///                                         `lastPathComponent` or `pathExtension.
        /// - bodyPartFileNotReachable:             The file at the `fileURL` provided was not reachable.
        /// - bodyPartFileNotReachableWithError:    Attempting to check the reachability of the `fileURL` provided threw
        ///                                         an error.
        /// - bodyPartFileIsDirectory:              The file at the `fileURL` provided is actually a directory.
        /// - bodyPartFileSizeNotAvailable:         The size of the file at the `fileURL` provided was not returned by
        ///                                         the system.
        /// - bodyPartFileSizeQueryFailedWithError: The attempt to find the size of the file at the `fileURL` provided
        ///                                         threw an error.
        /// - bodyPartInputStreamCreationFailed:    An `InputStream` could not be created for the provided `fileURL`.
        /// - outputStreamCreationFailed:           An `OutputStream` could not be created when attempting to write the
        ///                                         encoded data to disk.
        /// - outputStreamFileAlreadyExists:        The encoded body data could not be writtent disk because a file
        ///                                         already exists at the provided `fileURL`.
        /// - outputStreamURLInvalid:               The `fileURL` provided for writing the encoded body data to disk is
        ///                                         not a file URL.
        /// - outputStreamWriteFailed:              The attempt to write the encoded body data to disk failed with an
        ///                                         underlying error.
        /// - inputStreamReadFailed:                The attempt to read an encoded body part `InputStream` failed with
        ///                                         underlying system error.
        public enum MultipartEncodingFailureReason {
            case bodyPartURLInvalid(url: URL)
            case bodyPartFilenameInvalid(in: URL)
            case bodyPartFileNotReachable(at: URL)
            case bodyPartFileNotReachableWithError(atURL: URL, error: Error)
            case bodyPartFileIsDirectory(at: URL)
            case bodyPartFileSizeNotAvailable(at: URL)
            case bodyPartFileSizeQueryFailedWithError(forURL: URL, error: Error)
            case bodyPartInputStreamCreationFailed(for: URL)
            
            case outputStreamCreationFailed(for: URL)
            case outputStreamFileAlreadyExists(at: URL)
            case outputStreamURLInvalid(url: URL)
            case outputStreamWriteFailed(error: Error)
            
            case inputStreamReadFailed(error: Error)
        }
        
        /// The underlying reason the response validation error occurred.
        ///
        /// - dataFileNil:             The data file containing the server response did not exist.
        /// - dataFileReadFailed:      The data file containing the server response could not be read.
        /// - missingContentType:      The response did not contain a `Content-Type` and the `acceptableContentTypes`
        ///                            provided did not contain wildcard type.
        /// - unacceptableContentType: The response `Content-Type` did not match any type in the provided
        ///                            `acceptableContentTypes`.
        /// - unacceptableStatusCode:  The response status code was not acceptable.
        public enum ResponseValidationFailureReason {
            case dataFileNil
            case dataFileReadFailed(at: URL)
            case missingContentType(acceptableContentTypes: [String])
            case unacceptableContentType(acceptableContentTypes: [String], responseContentType: String)
            case unacceptableStatusCode(code: Int)
        }
        
        /// The underlying reason the response serialization error occurred.
        ///
        /// - inputDataNil:                    The server response contained no data.
        /// - inputDataNilOrZeroLength:        The server response contained no data or the data was zero length.
        /// - inputFileNil:                    The file containing the server response did not exist.
        /// - inputFileReadFailed:             The file containing the server response could not be read.
        /// - stringSerializationFailed:       String serialization failed using the provided `String.Encoding`.
        /// - jsonSerializationFailed:         JSON serialization failed with an underlying system error.
        /// - propertyListSerializationFailed: Property list serialization failed with an underlying system error.
        public enum ResponseSerializationFailureReason {
            case inputDataNil
            case inputDataNilOrZeroLength
            case inputFileNil
            case inputFileReadFailed(at: URL)
            case stringSerializationFailed(encoding: String.Encoding)
            case jsonSerializationFailed(error: Error)
            case propertyListSerializationFailed(error: Error)
        }
        
        case invalidURL(url: String)
        case parameterEncodingFailed(reason: ParameterEncodingFailureReason)
        case multipartEncodingFailed(reason: MultipartEncodingFailureReason)
        case responseValidationFailed(reason: ResponseValidationFailureReason)
        case responseSerializationFailed(reason: ResponseSerializationFailureReason)
    }
}







