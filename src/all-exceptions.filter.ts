import {
  Catch,
  ArgumentsHost,
  HttpStatus,
  HttpException,
} from '@nestjs/common';
import { BaseExceptionFilter } from '@nestjs/core';
import { Request, Response } from 'express';

import { CustomLoggerService } from './custom-logger/custom-logger.service';
import {
  PrismaClientInitializationError,
  PrismaClientKnownRequestError,
  PrismaClientRustPanicError,
  PrismaClientUnknownRequestError,
  PrismaClientValidationError,
} from '@prisma/client/runtime/library';

type ResponseObject = {
  statusCode: number;
  timestamp: string;
  path: string;
  response: string | object;
};

@Catch()
export class AllExceptionsFilter extends BaseExceptionFilter {
  private readonly logger = new CustomLoggerService(AllExceptionsFilter.name);

  catch(exception: unknown, host: ArgumentsHost): void {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();
    const responseObject: ResponseObject = {
      statusCode: 500,
      timestamp: new Date().toISOString(),
      path: request.url,
      response: '',
    };

    if (exception instanceof HttpException) {
      responseObject.statusCode = exception.getStatus();
      responseObject.response = exception.getResponse();
    } else if (exception instanceof PrismaClientValidationError) {
      responseObject.statusCode = 422;
      responseObject.response = exception.message.replaceAll(/\n/g, '');
    } else if (exception instanceof PrismaClientInitializationError) {
      responseObject.statusCode = 422;
      responseObject.response = exception.message.replaceAll(/\n/g, '');
    } else if (exception instanceof PrismaClientRustPanicError) {
      responseObject.statusCode = 422;
      responseObject.response = exception.message.replaceAll(/\n/g, '');
    } else if (exception instanceof PrismaClientKnownRequestError) {
      responseObject.statusCode = 422;
      responseObject.response = exception.message.replaceAll(/\n/g, '');
    } else if (exception instanceof PrismaClientUnknownRequestError) {
      responseObject.statusCode = 422;
      responseObject.response = exception.message.replaceAll(/\n/g, '');
    } else {
      responseObject.statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
      responseObject.response = 'Internal Server Error';
    }

    response.status(responseObject.statusCode).json(responseObject);
    this.logger.error(responseObject.response, AllExceptionsFilter.name);
    super.catch(exception, host);
  }
}
