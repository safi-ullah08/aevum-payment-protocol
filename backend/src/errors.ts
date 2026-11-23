/** Thrown by every stub. The Fastify error handler maps it to HTTP 501. */
export class NotImplementedError extends Error {
  constructor(what: string) {
    super(`${what} is not implemented`);
    this.name = 'NotImplementedError';
  }
}
